import 'package:watheq_ecommerce/features/wallet/data/datasources/cache_datasource.dart';
import 'package:watheq_ecommerce/features/wallet/data/model/wallet.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/wallet_repository.dart';

class WalletRepoImpl implements WalletRepo {
  final CacheDataSource cacheDataSource;

  const WalletRepoImpl({required this.cacheDataSource});

  @override
  Future<Either<Failure, Unit>> addNewWallet({required Wallet wallet}) {
    return cacheDataSource.addNewWalletData(wallet: wallet);
  }

  @override
  Future<Either<Failure, Wallet>> getWalletById({required int id}) {
    return cacheDataSource.getWalletDataById(walletId: id);
  }

  @override
  Future<Either<Failure, Unit>> deleteWalletById({required int id}) {
    return cacheDataSource.deleteWalletDataById(walletId: id);
  }

  @override
  Future<Either<Failure, List<Wallet>>> getAllWallets() {
    return cacheDataSource.getAllWalletsData();
  }
}