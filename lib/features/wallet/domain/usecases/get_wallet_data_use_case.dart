import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/model/wallet.dart';
import '../repository/wallet_repository.dart';

class GetWalletDataUseCase {
  final WalletRepo walletRepo;

  const GetWalletDataUseCase({required this.walletRepo});

  Future<Either<Failure, Wallet>> call({required int walletId}) async {
    return await walletRepo.getWalletById(id: walletId);
  }
}