import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/features/store/data/model/category.dart';

abstract class CategoryRepoAb {
  Future<Either<AppException, List<Category>>> fetchCategories();
}
