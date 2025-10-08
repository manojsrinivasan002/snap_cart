import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/features/store/data/model/product_res.dart';
import 'package:snap_cart/features/store/data/repo%20imp/product_repo_imp.dart';

class FetchProductUsecase {
  final ProductRepoImp productRepoImp;
  FetchProductUsecase(this.productRepoImp);

  Future<Either<AppException, ProductRes>> call({required int skip, required int limit}) async {
    return await productRepoImp.fetchProducts(skip: skip, limit: limit);
  }
}
