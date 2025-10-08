import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/features/store/data/model/product_res.dart';

abstract class ProductRepoAb {
  Future<Either<AppException, ProductRes>> fetchProducts({required int skip, required int limit});
}
