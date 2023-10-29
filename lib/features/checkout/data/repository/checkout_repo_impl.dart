import 'package:watheq_ecommerce/features/checkout/data/model/visa.dart';
import 'package:watheq_ecommerce/features/wallet/data/model/wallet.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../wallet/data/datasources/cache_datasource.dart';
import '../../domain/repository/checkout_repository.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final CacheDataSource cacheDataSource;

  CheckoutRepoImpl({required this.cacheDataSource});

  Future<Either<Failure, List<Wallet>>> getAllVisas() {
    return cacheDataSource.getAllWalletsData();
  }
}