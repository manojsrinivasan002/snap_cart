import 'package:dartz/dartz.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/core/service/network/api_client.dart';
import 'package:snap_cart/core/utility/constants.dart';

abstract class ProdudctDsAb {
  Future<Either<AppException, Map<String, dynamic>>> fetchProducts({
    required int skip,
    required int limit,
  });
}

class ProductDs implements ProdudctDsAb {
  final ApiClient _apiClient;
  ProductDs(this._apiClient);
  @override
  Future<Either<AppException, Map<String, dynamic>>> fetchProducts({
    required int skip,
    required int limit,
  }) async {
    final response = await _apiClient.get(Constants.productsEndPoint);
    return response.fold((error) => Left(error), (response) {
      if (response is Map<String, dynamic>) {
        return Right(response);
      }
      return Left(AppException(message: "Invalid products format", statusCode: -1));
    });
  }
}
