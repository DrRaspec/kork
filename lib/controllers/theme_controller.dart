import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/views/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final SharedPreferences prefs;

  ThemeController(this.prefs);

  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  ThemeMode get currentThemeMode => themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  void _loadThemeFromPrefs() {
    bool isDarkMode = prefs.getBool("isDarkMode") ?? false;
    themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
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
}
