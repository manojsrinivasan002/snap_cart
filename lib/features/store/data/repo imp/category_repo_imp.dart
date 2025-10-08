import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/features/store/data/datasource/category_ds.dart';
import 'package:snap_cart/features/store/data/model/category.dart';
import 'package:snap_cart/features/store/domain/repo%20ab/category_repo_ab.dart';

class CategoryRepoImp implements CategoryRepoAb {
  final CategoryDs categoryDs;

  CategoryRepoImp(this.categoryDs);

  @override
  Future<Either<AppException, List<Category>>> fetchCategories() async {
    final result = await categoryDs.fetchCategories();
    return result.fold((error) => Left(error), (data) {
      try {
        if (data is List) {
          final categories = data
              .whereType<Map<String, dynamic>>()
              .map<Category>((item) => Category.fromJson(item))
              .toList();
          return Right(categories);
        } else {
          return Left(AppException(message: "Invalid categories response format", statusCode: -1));
        }
      } catch (e) {
        return Left(AppException(message: "Failed to parse categories: $e", statusCode: -1));
      }
    });
  }
}
