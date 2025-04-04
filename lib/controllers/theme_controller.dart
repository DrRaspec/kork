import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/main.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final SharedPreferences prefs;
  ThemeController(this.prefs);

  final Rx<ThemeMode> themeMode = ThemeMode.dark.obs;
  var fontFamily = 'Poppins'.obs;
  var isProcessingThemeChange = false.obs;

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

  Future<void> toggleTheme() async {
    // Prevent multiple rapid changes
    if (isProcessingThemeChange.value) return;
    isProcessingThemeChange.value = true;

    bool isDark = themeMode.value == ThemeMode.dark;
    themeMode.value = isDark ? ThemeMode.light : ThemeMode.dark;
    await prefs.setBool("isDarkMode", !isDark);

    // Apply the theme immediately
    Get.changeThemeMode(themeMode.value);

    // Ensure the correct theme data is applied
    ThemeData updatedTheme = themeMode.value == ThemeMode.dark
        ? darkMode.copyWith(
            textTheme: darkMode.textTheme.apply(fontFamily: fontFamily.value),
          )
        : lightMode.copyWith(
            textTheme: lightMode.textTheme.apply(fontFamily: fontFamily.value),
          );

    Get.changeTheme(updatedTheme);

    // Give the UI time to apply theme changes before navigation
    await Future.delayed(const Duration(milliseconds: 300));

    // Force a complete UI rebuild
    Get.offAll(() => const MainView(), transition: Transition.fade);

    // Release the processing lock after a short delay
    await Future.delayed(const Duration(milliseconds: 200));
    isProcessingThemeChange.value = false;
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
