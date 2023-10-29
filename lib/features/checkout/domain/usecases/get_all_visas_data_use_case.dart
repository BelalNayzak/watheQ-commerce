import 'package:dartz/dartz.dart';
import 'package:watheq_ecommerce/features/wallet/data/model/wallet.dart';
import '../../../../core/error/failures.dart';
import '../../data/model/visa.dart';
import '../../data/repository/checkout_repo_impl.dart';
import '../repository/checkout_repository.dart';

class GetAllVisasDataUseCase {
  final CheckoutRepo checkoutRepo;

  const GetAllVisasDataUseCase({required this.checkoutRepo});

  Future<Either<Failure, List<Wallet>>> call() async {
    return await checkoutRepo.getAllVisas();
  }
}