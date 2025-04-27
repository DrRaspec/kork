import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route == Routes.splashScreen) {
      return null;
    }

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
    if (route == Routes.splashScreen) {
      return null;
    }

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
    if (route == Routes.splashScreen ||
        route == Routes.chooseLanguage ||
        route == Routes.firstOnBoarding) {
      return null;
    }

    final prefs = Get.find<SharedPreferences>();

    final hasSelectedLanguage = prefs.getBool('hasSelectedLanguage') ?? false;
    if (!hasSelectedLanguage) {
      return const RouteSettings(name: Routes.chooseLanguage);
    }

    final hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;
    if (!hasCompletedOnboarding) {
      return const RouteSettings(name: Routes.firstOnBoarding);
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
    try {
      String url = dotenv.maybeGet('API_URL')!;
      var token = await storage.read(key: 'token');
      final dio = Dio()
        ..interceptors.add(AppLogInterceptor())
        ..options = BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Authorization': 'Bearer $token'
          },
        );
      await dio.post('/logout');
    } catch (_) {
    } finally {
      final hasCompletedOnboarding =
          prefs.getBool('hasCompletedOnboarding') ?? false;
      final hasSelectedLanguage = prefs.getBool('hasSelectedLanguage') ?? false;

      await storage.deleteAll();
      await prefs.clear();

      await prefs.setBool('hasCompletedOnboarding', hasCompletedOnboarding);
      await prefs.setBool('hasSelectedLanguage', hasSelectedLanguage);

      Get.offAllNamed(Routes.login);
    }
  }
}

class ApiService extends GetxService {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    dio.interceptors.add(AppLogInterceptor());
    dio.options.baseUrl = dotenv.env['API_URL']!;
    dio.options.connectTimeout = const Duration(minutes: 1);
    dio.options.receiveTimeout = const Duration(minutes: 1);

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
