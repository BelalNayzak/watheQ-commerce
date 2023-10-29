import 'package:dio/dio.dart';
import 'package:watheq_ecommerce/core/internet_connection/network_status.dart';
import 'package:watheq_ecommerce/features/home/data/model/all_products_response_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/debugging_utils/debugging_helper.dart';
import '../../../../core/utils/network_utils/api_endpoints.dart';
import '../../../../core/utils/network_utils/dio_helper.dart';
import '../../data/model/product_model.dart';
import 'package:dartz/dartz.dart';

// Note: there could be more than 1 datasource exist (ex. if we use 2 apis or may be we have data on fire base as well)
// so that it's useful to make things abstract and implement with our needs
abstract class HomeRemoteDatasource {
  Future<Either<Failure, List<Product>>> getAllProducts();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final DioHelper dioHelper;

  HomeRemoteDatasourceImpl({required this.dioHelper});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() {
    return _basicErrorHandling<List<Product>>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          url: '$getAllItemsEndPoint',
        );
        AllProductsResponseModel response = AllProductsResponseModel.fromJson(f.data);
        return response.products ?? [];
      },
      onServerError: (exception) async {
        return ServerFailure(error: 'Server Error', code: 500, message: 'Server Error');
      },
    );
  }
}

// Note: extension for handling remote requests errors with its callbacks
extension on HomeRemoteDatasource {
  Future<Either<Failure, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<Failure> Function(ServerException exception)? onServerError,
    Future<Failure> Function(CacheException exception)? onCacheError,
    Future<Failure> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on ServerException catch (e, s) {
      // recordError(e, s);
      debugPrinter(s.toString());
      if (onServerError != null) {
        final f = await onServerError(e);
        return Left(f);
      }
      return Left(ServerFailure(error: 'Server Error', code: 500, message: 'Server Error'));
    } on CacheException catch (e, s) {
      // recordError(e, s);
      debugPrinter(e.toString());
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return Left(CacheFailure());
    } catch (e, s) {
      // recordError(e, s);
      debugPrinter(s.toString());
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(UnexpectedFailure());
    }
  }
}