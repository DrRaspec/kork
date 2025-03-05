import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/main.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final SharedPreferences prefs;

  ThemeController(this.prefs);

  final Rx<ThemeMode> themeMode = ThemeMode.dark.obs;
  var fontFamily = 'Poppins'.obs;

  ThemeMode get currentThemeMode => themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  void _loadThemeFromPrefs() {
    bool isDarkMode = prefs.getBool("isDarkMode") ?? true;
    themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    String savedLang = prefs.getString(LanguageController.LANGUAGE_KEY) ?? 'en';
    fontFamily.value = savedLang == 'en' ? 'Poppins' : 'KantumruyPro';
  }

  void toggleTheme() {
    bool isDark = themeMode.value == ThemeMode.dark;
    themeMode.value = isDark ? ThemeMode.light : ThemeMode.dark;
    prefs.setBool("isDarkMode", !isDark);

    Get.changeThemeMode(themeMode.value);

    // Restart the app with a fresh rebuild
    Future.delayed(const Duration(milliseconds: 200), () {
      Get.offAll(() => const MainView());
    });
  }

  void updateFontFamily(String language) {
    fontFamily.value = language == 'en' ? 'Poppins' : 'KantumruyPro';

    ThemeData newTheme = Get.isDarkMode
        ? darkMode.copyWith(
            textTheme: darkMode.textTheme.apply(fontFamily: fontFamily.value),
          )
        : lightMode.copyWith(
            textTheme: lightMode.textTheme.apply(fontFamily: fontFamily.value),
          );

    Get.changeTheme(newTheme);
  }
}
