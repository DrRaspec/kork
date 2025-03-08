// part of 'package:kork/main.dart';

// class LanguageController extends GetxController {
//   static const LANGUAGE_KEY = 'selected_language';

//   var currentLocale = Get.deviceLocale ?? const Locale('en');
//   var isEnglish = true.obs;
//   var isNavigating = false;

//   final SharedPreferences _prefs;
//   LanguageController(this._prefs);

//   @override
//   void onInit() {
//     super.onInit();
//     loadSavedLanguage();
//   }

//   void loadSavedLanguage() {
//     String savedLang = _prefs.getString(LANGUAGE_KEY) ?? 'en';
//     isEnglish.value = savedLang == 'en';
//     currentLocale = Locale(savedLang);
//     Get.updateLocale(currentLocale);
//   }

//   void switchLanguage(bool value) async {
//     isEnglish.value = value;
//     String newLang = value ? 'en' : 'km';
//     currentLocale = Locale(newLang);

//     await _prefs.setString(LANGUAGE_KEY, newLang);
//     Get.updateLocale(currentLocale);

//     // Update font family
//     Get.find<ThemeController>().updateFontFamily(newLang);

//     // Force a complete UI rebuild
//     Future.delayed(const Duration(milliseconds: 100), () {
//       Get.offAll(() => const MainView());
//     });
//   }
// }

part of 'package:kork/main.dart';

class LanguageController extends GetxController {
  static const LANGUAGE_KEY = 'selected_language';

  var currentLocale = Get.deviceLocale ?? const Locale('en');
  var isEnglish = true.obs;
  var isProcessing =
      false.obs; // Add this flag to prevent multiple rapid changes

  final SharedPreferences _prefs;
  LanguageController(this._prefs);

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  void loadSavedLanguage() {
    String savedLang = _prefs.getString(LANGUAGE_KEY) ?? 'en';
    isEnglish.value = savedLang == 'en';
    currentLocale = Locale(savedLang);
    Get.updateLocale(currentLocale);
  }

  // Future<void> switchLanguage(bool value) async {
  //   // Prevent multiple rapid changes
  //   if (isProcessing.value) return;
  //   isProcessing.value = true;

  //   isEnglish.value = value;
  //   String newLang = value ? 'en' : 'km';
  //   currentLocale = Locale(newLang);

  //   await _prefs.setString(LANGUAGE_KEY, newLang);
  //   Get.updateLocale(currentLocale);

  //   // Update font family
  //   Get.find<ThemeController>().updateFontFamily(newLang);

  //   // Force a complete UI rebuild
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   Get.offAll(() => const MainView());

  //   // Release the lock after navigation completes
  //   isProcessing.value = false;
  // }

  Future<void> switchLanguage(bool value) async {
    // Prevent multiple rapid changes
    if (isProcessing.value) return;
    isProcessing.value = true;

    isEnglish.value = value;
    String newLang = value ? 'en' : 'km';
    currentLocale = Locale(newLang);

    await _prefs.setString(LANGUAGE_KEY, newLang);
    Get.updateLocale(currentLocale);

    // Update font family
    Get.find<ThemeController>().updateFontFamily(newLang);

    // Force a UI rebuild but don't navigate
    await Future.delayed(const Duration(milliseconds: 300));

    // Release the lock
    isProcessing.value = false;
  }
}
