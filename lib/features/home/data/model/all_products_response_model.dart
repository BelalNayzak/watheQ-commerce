import 'package:watheq_ecommerce/features/home/data/model/product_model.dart';

class AllProductsResponseModel {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  AllProductsResponseModel({this.products, this.total, this.skip, this.limit});

  AllProductsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}