import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kork/l10n/l10n.dart';
import 'package:kork/routes/app_routes.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'bindings/initial_binding.dart';
part 'controllers/language_controller.dart';

void main() {
  Get.put(LanguageController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      supportedLocales: L10n.all,
      // Use device's default locale
      locale: Get.find<LanguageController>().currentLocale,
      // Fallback if device locale is not supported
      fallbackLocale: const Locale('en'),
      // locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: ThemeMode.system,
      theme: lightMode.copyWith(
        textTheme: lightMode.textTheme.apply(
          fontFamily: 'Poppins',
        ),
      ),
      darkTheme: darkMode.copyWith(
        textTheme: darkMode.textTheme.apply(
          fontFamily: 'Poppins',
        ),
      ),
      getPages: appRoutes,
      initialRoute: Routes.login,
    );
  }
}
