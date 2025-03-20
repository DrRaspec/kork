import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    // super.onRequest(options, handler);
    debugPrint('📨 📨 📨 Request 📨 📨 📨');
    debugPrint('[${options.method}]: ${options.uri}');
    debugPrint('Header: ${options.headers}');
    debugPrint('Data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    // super.onResponse(response, handler);
    debugPrint('✅ ✅ ✅ Response ✅ ✅ ✅');
    debugPrint('[${response.statusCode}]: ${response.requestOptions.uri}');
    debugPrint('Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    // super.onError(err, handler);
    debugPrint('😓 😓 😓 DioException 😓 😓 😓');
    debugPrint('Response Text:');
    debugPrint(
        '[${err.response?.statusCode}]: ${err.response?.requestOptions.uri}');
    debugPrint('${err.response?.data}');
    debugPrint('$err');
    handler.next(err);
  }
}
