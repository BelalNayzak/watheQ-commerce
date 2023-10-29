import 'package:watheq_ecommerce/features/home/data/datasources/home_remote_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/internet_connection/network_status.dart';
import '../../data/model/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/home_repository.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDatasource remoteDatasource;
  final NetworkStatus networkStatus;

  HomeRepoImpl({required this.remoteDatasource, required this.networkStatus});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (!await networkStatus.isConnected) {
      return Left(NoInternetFailure(message: 'No internet connection.'));
    }

    return remoteDatasource.getAllProducts();
  }
}