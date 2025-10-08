import 'package:equatable/equatable.dart';
import 'package:snap_cart/features/store/data/model/product.dart';

class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  final bool hasMore;
  ProductsLoaded({required this.products, this.hasMore = true});

  ProductsLoaded copyWith({List<Product>? products, bool? hasMore, String? currentCategory}) {
    return ProductsLoaded(products: products ?? this.products, hasMore: hasMore ?? this.hasMore);
  }

  @override
  List<Object?> get props => [products, hasMore];
}

class ProductsError extends ProductState {
  final String errMsg;
  ProductsError({required this.errMsg});

  @override
  List<Object?> get props => [errMsg];
}
