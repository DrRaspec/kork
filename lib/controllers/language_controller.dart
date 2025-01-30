part of 'package:kork/main.dart';

// for code language like km en ...
// class LanguageController extends GetxController {
//   var currentLocale = Get.deviceLocale ?? const Locale('en');

//   void switchLanguage(String languageCode) {
//     Locale locale = Locale(languageCode);
//     currentLocale = locale;
//     Get.updateLocale(locale);
//   }
// }

// for boolean
class LanguageController extends GetxController {
  static const LANGUAGE_KEY = 'selected_language';

  var currentLocale = Get.deviceLocale ?? const Locale('en');
  var isEnglish = true.obs;

  final SharedPreferences _prefs;
  LanguageController(this._prefs);

  @override
  void onInit() {
    super.onInit();
    loadSaveLanguage();
    // Initialize isEnglish based on current locale
    // isEnglish.value = currentLocale.languageCode == 'en';
  }

  void loadSaveLanguage() {
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
  }
}
