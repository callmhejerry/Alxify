import 'package:alxify/network_util/endpoints.dart';
import 'package:alxify/network_util/request_interceptor.dart';
import 'package:dio/dio.dart';

import 'error_interceptor.dart';

class AppClient {
  final Dio dioClient = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
    ),
  )..interceptors.addAll([
      RequestInterceptor(),
      ErrorInterceptor(),
    ]);

  static AppClient get instance => AppClient._();

  AppClient._();

  Future<Map<String, dynamic>?> get({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response<Map<String, dynamic>> response =
        await dioClient.get<Map<String, dynamic>>(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  Future<Map<String, dynamic>?> post({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await dioClient.post<Map<String, dynamic>>(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
