import 'package:dartz/dartz.dart';
import 'package:watheq_ecommerce/features/home/data/model/product_model.dart';
import '../../../../core/error/failures.dart';
import '../repository/home_repository.dart';

class GetAllProductsUseCase {
  final HomeRepo homeRepo;

  const GetAllProductsUseCase({required this.homeRepo});

  Future<Either<Failure, List<Product>>> call() async {
    return await homeRepo.getAllProducts();
  }
}