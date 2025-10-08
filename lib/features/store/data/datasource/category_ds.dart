import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/core/service/network/api_client.dart';
import 'package:snap_cart/core/utility/constants.dart';

abstract class CategoryDsAb {
  Future<Either<AppException, List<dynamic>>> fetchCategories();
}

class CategoryDs implements CategoryDsAb {
  final ApiClient _apiClient;
  CategoryDs(this._apiClient);
  @override
  Future<Either<AppException, List<dynamic>>> fetchCategories() async {
    final response = await _apiClient.get(Constants.categoriesEndPoint);
    return response.fold((error) => Left(error), (response) {
      if (response is List) {
        return Right(response);
      }
      return Left(AppException(message: "Invalid categories format", statusCode: -1));
    });
  }
}
