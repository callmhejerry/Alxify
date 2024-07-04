import 'package:alxify/network_util/network_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(err);
    }
    if (err.response != null || err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.data["error"]["status"];
      final message = err.response?.data["error"]["message"];

      switch (statusCode) {
        case 400:
          throw OtherException(message: message, errorCode: statusCode);
        case 500:
          throw const ServerException();
        case 502:
          throw const ServerException();
        case 503:
          throw const ServerException();
        case 429:
          throw OtherException(message: message, errorCode: statusCode);
        case 401:
          throw const ExpiredTokenException();
        case 403:
          throw const ServerException();
        case 404:
          throw const NotFoundException();
        default:
          throw OtherException(message: message, errorCode: statusCode);
      }
    }
    switch (err.type) {
      case DioExceptionType.connectionError:
        throw const NoInternetException();
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        throw const ConnectionException();
      case DioExceptionType.unknown:
        if (err.error != null) {
          if (kDebugMode) {
            print("Error");
            print(err.error);
          }
        }
      default:
        throw const OtherException(
          message: "Something went wrong, please try again",
        );
    }
    super.onError(err, handler);
  }
}
