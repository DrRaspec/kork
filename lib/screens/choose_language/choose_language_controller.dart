part of 'choose_language_view.dart';

class ChooseLanguageViewController extends GetxController {
  var languageController = Get.find<LanguageController>();

  void changeLanguage(var isEnglish) {
    languageController.switchLanguage(isEnglish);

    final prefs = Get.find<SharedPreferences>();
    prefs.setBool('hasSelectedLanguage', true);

    Get.toNamed(Routes.firstOnBoarding);
  }
}
