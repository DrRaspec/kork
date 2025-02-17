part of 'package:kork/main.dart';

class LanguageController extends GetxController {
  static const LANGUAGE_KEY = 'selected_language';

  var currentLocale = Get.deviceLocale ?? const Locale('en');
  var isEnglish = true.obs;
  var fontFamily = 'Poppins'.obs; // Default font family

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
    fontFamily.value =
        savedLang == 'km' ? 'KantumruyPro' : 'Poppins'; // Update font

    Get.updateLocale(currentLocale);
  }

  void switchLanguage(bool value) async {
    isEnglish.value = value;
    String newLang = value ? 'en' : 'km';
    currentLocale = Locale(newLang);
    fontFamily.value =
        newLang == 'km' ? 'KantumruyPro' : 'Poppins'; // Change font

    await _prefs.setString(LANGUAGE_KEY, newLang);
    Get.updateLocale(currentLocale);
  }
}
