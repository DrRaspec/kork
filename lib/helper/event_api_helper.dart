import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kork/utils/app_log_interceptor.dart';

class EventApiHelper {
  static String url = dotenv.maybeGet('API_URL') ?? 'http://10.0.2.2:8000/api';
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
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> post(String endpoint,
      {dynamic data, bool isFormData = false}) async {
    try {
      return await _dio.post(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> put(String endpoint,
      {dynamic data, bool isFormData = false}) async {
    try {
      return await _dio.put(
        endpoint,
        data: isFormData ? FormData.fromMap(data) : data,
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Response _handleError(dynamic error) {
    if (error is DioException) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: error.response?.statusCode,
        data: {'error': error.message},
      );
    }
    return Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 500,
      data: {'error': 'Unknown error'},
    );
  }
}
