import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kork/l10n/l10n.dart';
import 'package:kork/routes/app_routes.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/views/event_view.dart';
import 'package:kork/views/home_view.dart';
import 'package:kork/views/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bindings/initial_binding.dart';
part 'controllers/language_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put(LanguageController(prefs));
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
    return GetMaterialApp(
      initialBinding: InitialBinding(prefs),
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
      initialRoute: Routes.main,
    );
  }
}
