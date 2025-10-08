import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/features/store/data/model/category.dart';
import 'package:snap_cart/features/store/data/repo%20imp/category_repo_imp.dart';

class FetchCategoriesUsecase {
  final CategoryRepoImp categoryRepoImp;
  FetchCategoriesUsecase(this.categoryRepoImp);

  Future<Either<AppException, List<Category>>> call() async {
    return await categoryRepoImp.fetchCategories();
  }
}
