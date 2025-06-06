import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kork/controllers/theme_controller.dart';
import 'package:kork/l10n/l10n.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/routes/app_routes.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/main_screens/event/event_view.dart';
import 'package:kork/screens/main_screens/home/home_view.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/screens/main_screens/profile/profile_view.dart';
import 'package:kork/screens/main_screens/ticket/ticket_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bindings/initial_binding.dart';
part 'controllers/language_controller.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await loadEnvironment();
//   final prefs = await SharedPreferences.getInstance();
//
//   Get.put<SharedPreferences>(prefs, permanent: true);
//   Get.put(ThemeController(prefs), permanent: true);
//   Get.put(LanguageController(prefs), permanent: true);
//   Get.put(AuthService(), permanent: true);
//   Get.put<ApiService>(ApiService(), permanent: true);
//   Get.put(const FlutterSecureStorage());
//   Get.put(MainController(), permanent: true);
//
//   await GetStorage.init();
//   runApp(MainApp(prefs: prefs));
// }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await loadEnvironment();
  await GetStorage.init();

  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs, permanent: true);
  Get.put(ThemeController(prefs), permanent: true);
  Get.put(LanguageController(prefs), permanent: true);
  Get.put(AuthService(), permanent: true);
  Get.put(ApiService(), permanent: true);
  Get.put(MainController(), permanent: true);
  // FlutterNativeSplash.remove();

  runApp(MainApp(prefs: prefs));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.prefs,
  });
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    // return Obx(
    //   () => GetMaterialApp(
    //     themeMode: themeController.themeMode.value,
    //     debugShowCheckedModeBanner: false,
    //     initialBinding: InitialBinding(prefs),
    //     supportedLocales: L10n.all,
    //     locale: Get.find<LanguageController>().currentLocale,
    //     fallbackLocale: const Locale('en'),
    //     localizationsDelegates: const [
    //       AppLocalizations.delegate,
    //       GlobalMaterialLocalizations.delegate,
    //       GlobalWidgetsLocalizations.delegate,
    //       GlobalCupertinoLocalizations.delegate,
    //     ],
    //     theme: lightMode.copyWith(
    //       textTheme: lightMode.textTheme.apply(
    //         fontFamily: themeController.fontFamily.value,
    //       ),
    //     ),
    //     darkTheme: darkMode.copyWith(
    //       textTheme: darkMode.textTheme.apply(
    //         fontFamily: themeController.fontFamily.value,
    //       ),
    //     ),
    //     getPages: appRoutes,
    //     initialRoute: Routes.splashScreen,
    //   ),
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(prefs),
      supportedLocales: L10n.all,
      locale: Get.find<LanguageController>().currentLocale,
      fallbackLocale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: lightMode.copyWith(
        textTheme: lightMode.textTheme.apply(
          fontFamily: themeController.fontFamily.value,
        ),
      ),
      darkTheme: darkMode.copyWith(
        textTheme: darkMode.textTheme.apply(
          fontFamily: themeController.fontFamily.value,
        ),
      ),
      themeMode: themeController.themeMode.value,
      getPages: appRoutes,
      initialRoute: Routes.splashScreen,
    );
  }
}

Future<void> loadEnvironment() async {
  try {
    await dotenv.load(fileName: ".env");
    // print("API_URL: ${dotenv.env['API_URL'] ?? 'Not found'}");
  } catch (e) {
    print("Error loading .env file: $e");
  }
}
