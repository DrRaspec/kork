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
  var currentLocale = Get.deviceLocale ?? const Locale('en');
  var isEnglish = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize isEnglish based on current locale
    isEnglish.value = currentLocale.languageCode == 'en';
  }

  void switchLanguage(bool value) {
    isEnglish.value = value;
    currentLocale = Locale(value ? 'en' : 'km');
    Get.updateLocale(currentLocale);
  }
}
