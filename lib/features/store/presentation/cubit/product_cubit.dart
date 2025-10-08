import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_cart/features/store/domain/usecase/product_usecase.dart';
import 'package:snap_cart/features/store/presentation/state/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductUsecase _fetchProductUsecase;

  int _skip = 0;
  final int _limit = 30;
  bool _isFetching = false;
  bool _hasMore = true;

  ProductCubit(this._fetchProductUsecase) : super(ProductsInitial());

  // Fetch products by category with pagination
  // Future<void> fetchProductsByCategory(String category) async {
  //   if (_isFetching) return;
  //   _isFetching = true;
  //   // Reset for new category
  //   _skip = 0;
  //   _hasMore = true;
  //   _currentCategory = category;
  //   emit(ProductsLoading());
  //   final result = await _fetchProductUsecase.call(
  //     skip: _skip,
  //     limit: _limit,
  //     category: category,
  //   );
  //   result.fold(
  //     (error) => emit(ProductsError(errMsg: error.message)),
  //     (productRes) {
  //       _hasMore = productRes.products.length < (productRes.total ?? 0);
  //       emit(ProductsLoaded(
  //         products: productRes.products,
  //         hasMore: _hasMore,
  //         currentCategory: category,
  //       ));
  //       _skip += productRes.products.length;
  //     }
  //   );
  //   _isFetching = false;
  // }
  // // Load more products for current category
  // Future<void> loadMore() async {
  //   if (_isFetching || !_hasMore) return;
  //   _isFetching = true;
  //   final result = await _fetchProductUsecase.call(
  //     skip: _skip,
  //     limit: _limit,
  //     category: _currentCategory,
  //   );
  //   result.fold(
  //     (error) => print('Load more error: ${error.message}'),
  //     (productRes) {
  //       if (state is ProductsLoaded) {
  //         final currentState = state as ProductsLoaded;
  //         final updatedProducts = [...currentState.products, ...productRes.products];
  //         _hasMore = updatedProducts.length < (productRes.total ?? 0);
  //         emit(ProductsLoaded(
  //           products: updatedProducts,
  //           hasMore: _hasMore,
  //           currentCategory: _currentCategory,
  //         ));
  //         _skip += productRes.products.length;
  //       }
  //     }
  //   );
  //   _isFetching = false;
  // }
  Future<void> fetchProducts({bool loadMore = false}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (!loadMore) {
      _skip = 0;
      emit(ProductsLoading());
    }

    final result = await _fetchProductUsecase.call(skip: _skip, limit: _limit);

    result.fold((error) => emit(ProductsError(errMsg: error.message)), (productRes) {
      if (loadMore && state is ProductsLoaded) {
        final current = (state as ProductsLoaded).products;
        final updated = [...current, ...productRes.products];
        emit(ProductsLoaded(products: updated, hasMore: updated.length < productRes.total));
      } else {
        emit(
          ProductsLoaded(
            products: productRes.products,
            hasMore: productRes.products.length < productRes.total,
          ),
        );
      }
      _skip += _limit;
    });

    _isFetching = false;
  }
}
