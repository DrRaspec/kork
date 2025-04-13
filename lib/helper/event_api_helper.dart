import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kork/utils/app_log_interceptor.dart';

class EventApiHelper {
  static String url = dotenv.maybeGet('API_URL')!;
  static final Dio _dio = Dio()
    ..interceptors.add(AppLogInterceptor())
    ..options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
      },
    );

  static void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future<Response> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } on DioException {
      rethrow;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: endpoint),
        statusCode: 500,
        data: {'error': 'Unknown error: ${e.toString()}'},
      );
    }
  }

  static Future<Response> post(String endpoint,
      {dynamic data}) async {
    try {
      return await _dio.post(
        endpoint,
        data: data,
      );
    } on DioException {
      rethrow;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: endpoint),
        statusCode: 500,
        data: {'error': 'Unknown error: ${e.toString()}'},
      );
    }
  }

  static Future<Response> put(String endpoint,
      {dynamic data}) async {
    try {
      return await _dio.put(
        endpoint,
        data: data,
      );
    } on DioException {
      rethrow;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: endpoint),
        statusCode: 500,
        data: {'error': 'Unknown error: ${e.toString()}'},
      );
    }
  }

  static Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } on DioException {
      rethrow;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: endpoint),
        statusCode: 500,
        data: {'error': 'Unknown error: ${e.toString()}'},
      );
    }
  }

  static Future<Response> logout() async {
    try {
      return await _dio.delete('/logout');
    } on DioException {
      rethrow;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: '/logout'),
        statusCode: 500,
        data: {'error': 'Unknown error: ${e.toString()}'},
      );
    }
  }
}
