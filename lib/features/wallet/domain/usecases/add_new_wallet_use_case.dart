import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/model/wallet.dart';
import '../repository/wallet_repository.dart';

class AddNewWalletUseCase {
  final WalletRepo walletRepo;

  const AddNewWalletUseCase({required this.walletRepo});

  Future<Either<Failure, Unit>> call({required Wallet wallet}) async {
    return await walletRepo.addNewWallet(wallet: wallet);
  }
}