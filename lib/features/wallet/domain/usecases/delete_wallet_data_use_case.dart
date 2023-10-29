import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/model/wallet.dart';
import '../repository/wallet_repository.dart';

class DeleteWalletDataUseCase {
  final WalletRepo walletRepo;

  const DeleteWalletDataUseCase({required this.walletRepo});

  Future<Either<Failure, Unit>> call({required int walletId}) async {
    return await walletRepo.deleteWalletById(id: walletId);
  }
}