import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/features/store/data/datasource/product_ds.dart';
import 'package:snap_cart/features/store/data/model/product_res.dart';
import 'package:snap_cart/features/store/domain/repo%20ab/product_repo_ab.dart';

class ProductRepoImp implements ProductRepoAb {
  final ProductDs produdctDs;

  ProductRepoImp(this.produdctDs);

  @override
  Future<Either<AppException, ProductRes>> fetchProducts({
    required int skip,
    required int limit,
  }) async {
    final result = await produdctDs.fetchProducts(skip: skip, limit: limit);
    return result.fold((error) => Left(error), (data) {
      try {
        final productResponse = ProductRes.fromJson(data);
        return Right(productResponse);
      } catch (e) {
        return Left(AppException(message: "Failed to parse products response: $e", statusCode: -1));
      }
    });
  }
}
