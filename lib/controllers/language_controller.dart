part of 'package:kork/main.dart';

class LanguageController extends GetxController {
  static const LANGUAGE_KEY = 'selected_language';

  var currentLocale = Get.deviceLocale ?? const Locale('en');
  var isEnglish = true.obs;

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

  void switchLanguage(bool value) async {
    isEnglish.value = value;
    String newLang = value ? 'en' : 'km';
    currentLocale = Locale(newLang);

    await _prefs.setString(LANGUAGE_KEY, newLang);
    Get.updateLocale(currentLocale);

    // Get.forceAppUpdate();
    Get.find<ThemeController>().updateFontFamily(newLang);

    Future.delayed(const Duration(milliseconds: 200), () {
      Get.offAll(() => const MainView());
    });
  }
}
