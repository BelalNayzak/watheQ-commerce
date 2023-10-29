import 'package:dartz/dartz.dart';
import 'package:watheq_ecommerce/features/wallet/data/model/wallet.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/visa.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, List<Wallet>>> getAllVisas();
}