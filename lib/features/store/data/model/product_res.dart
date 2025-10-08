import 'package:snap_cart/features/store/data/model/product.dart';

class ProductRes {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductRes({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductRes.fromJson(Map<String, dynamic> json) {
    return ProductRes(
      products: (json['products'] as List).map((product) => Product.fromJson(product)).toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
