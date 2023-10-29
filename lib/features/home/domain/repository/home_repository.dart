import '../../../../core/error/failures.dart';
import '../../data/model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Product>>> getAllProducts();
}