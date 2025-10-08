import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:snap_cart/core/error/app_exception.dart';
import 'package:snap_cart/core/utility/constants.dart';

class ApiClient {
  late final Dio _dio;

  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Constants.connectTimeout,
        receiveTimeout: Constants.receiveTimeout,
        headers: Constants.defaultHeaders,
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          queryParameters: true,
          error: true,
          showProcessingTime: true,
          showCUrl: true,
          canShowLog: true,
        ),
      );
    }
  }

  Future<Either<AppException, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(AppException(message: 'Something went wrong'));
    }
  }

  AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(
          message: 'Request timeout. Please try again',
          statusCode: error.response?.statusCode,
        );

      case DioExceptionType.unknown:
        return AppException(
          message: 'An unknown error occured',
          statusCode: error.response?.statusCode,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return AppException(message: 'Session expired. Please login again');
        }
        if (statusCode == 500) {
          return AppException(message: 'Server error. Please try again later');
        }
        return AppException(message: 'Request failed. Please try again', statusCode: statusCode);

      case DioExceptionType.cancel:
        return AppException(message: 'Request cancelled', statusCode: error.response?.statusCode);
      default:
        return AppException(
          message: 'Network error. Please try again',
          statusCode: error.response?.statusCode,
        );
    }
  }
}
