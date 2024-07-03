import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const header = {
      'x-rapidapi-key': '9f60022f6bmsh30b5b3b9fcabba2p1e5a5djsn1c555a46ff5b',
      'x-rapidapi-host': 'spotify23.p.rapidapi.com'
    };
    options.headers = header;
    if (kDebugMode) {
      print("Printing Request headers");
      print(options);
      print(options.uri);
      print(options.headers);
    }
    super.onRequest(options, handler);
  }
}
