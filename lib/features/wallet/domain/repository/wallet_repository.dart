import 'package:watheq_ecommerce/features/wallet/data/model/wallet.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class WalletRepo {
  Future<Either<Failure, Unit>> addNewWallet({required Wallet wallet});
  Future<Either<Failure, Wallet>> getWalletById({required int id});
  Future<Either<Failure, Unit>> deleteWalletById({required int id});
  Future<Either<Failure, List<Wallet>>> getAllWallets();
}