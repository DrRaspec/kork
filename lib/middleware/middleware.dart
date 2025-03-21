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

  Future<bool> isAuthenticated() async {
    final token = await storage.read(key: 'token');
    final id = await storage.read(key: 'id');
    return token != null && id != null;
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'id');
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
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            // Token expired or invalid
            Get.find<AuthService>().logout();
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
    if (e.type == DioExceptionType.connectionTimeout) {
      Get.snackbar(
        'Error',
        'Connection timeout. Please check your internet connection.',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        'Error',
        'Request failed',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
