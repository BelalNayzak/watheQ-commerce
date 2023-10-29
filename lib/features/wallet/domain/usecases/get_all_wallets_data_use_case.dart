import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/model/wallet.dart';
import '../../data/repository/wallet_repository_impl.dart';

class GetAllWalletsDataUseCase {
  final WalletRepoImpl walletRepo;

  const GetAllWalletsDataUseCase({required this.walletRepo});

  Future<Either<Failure, List<Wallet>>> call() async {
    return await walletRepo.getAllWallets();
  }
}