import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final prefs = Get.find<SharedPreferences>();
    final isLoggedIn = prefs.getBool('isLoggin') ?? false;

    if (!isLoggedIn) {
      return const RouteSettings(name: Routes.login);
    }
    return null;
  }
}

class NoAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final prefs = Get.find<SharedPreferences>();
    final isLoggedIn = prefs.getBool('isLoggin') ?? false;

    if (isLoggedIn) {
      return const RouteSettings(name: Routes.main);
    }
    return null;
  }
}

class OnBoardingMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final prefs = Get.find<SharedPreferences>();

    final hasSelectedLanguage = prefs.getBool('hasSelectedLanguage') ?? false;
    if (!hasSelectedLanguage) {
      return const RouteSettings(name: Routes.chooseLanguage);
    }

    final hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;
    if (hasCompletedOnboarding) {
      final isLoggedIn = prefs.getBool('isLoggin') ?? false;
      return RouteSettings(name: isLoggedIn ? Routes.main : Routes.login);
    }

    return null;
  }
}

class AuthService extends GetxService {
  final storage = const FlutterSecureStorage();
  late final SharedPreferences prefs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> isAuthenticated() async {
    final token = await storage.read(key: 'token');
    final id = await storage.read(key: 'id');
    return token != null && id != null;
  }

  Future<void> setLoggedIn(bool value) async {
    await prefs.setBool('isLoggin', value);
  }

  Future<void> login({required String token, required String id}) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'id', value: id);
    await setLoggedIn(true);
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'id');
    await setLoggedIn(false);
    Get.offAllNamed(Routes.login);
  }
}

class ApiService extends GetxService {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    dio.interceptors.add(AppLogInterceptor());
    dio.options.baseUrl = 'http://10.0.2.2:8000/api';
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            options.headers['Content-Type'] = 'application/json';
            options.headers['Accept'] = 'application/json';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            await Get.find<AuthService>().logout();
            return handler.reject(e);
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getUserData(String id) async {
    try {
      final response = await dio.get('/users/$id');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    String errorMessage = 'Request failed';

    if (e.type == DioExceptionType.connectionTimeout) {
      errorMessage =
          'Connection timeout. Please check your internet connection.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Server is taking too long to respond.';
    } else if (e.type == DioExceptionType.connectionError) {
      errorMessage = 'No internet connection.';
    } else if (e.response != null) {
      errorMessage =
          'Server error (${e.response?.statusCode}): ${e.response?.statusMessage}';
    }

    Get.snackbar(
      'Error',
      errorMessage,
      snackPosition: SnackPosition.TOP,
    );
  }
}
