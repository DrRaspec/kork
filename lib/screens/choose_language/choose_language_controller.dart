part of 'choose_language_view.dart';

class ChooseLanguageViewController extends GetxController {
  var languageController = Get.find<LanguageController>();

  void changeLanguage(var isEnglish) {
    languageController.switchLanguage(isEnglish);
    Get.toNamed(Routes.firstOnBoarding);
  }
}
