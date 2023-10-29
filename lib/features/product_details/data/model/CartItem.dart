import '../../../home/data/model/product_model.dart';

class CartItem {
  int quantity = 1;
  final Product product;

  CartItem({required this.quantity, required this.product});
}