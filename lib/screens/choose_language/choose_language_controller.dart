part of 'choose_language_view.dart';

class ChooseLanguageViewController extends GetxController {
  var languageController = Get.find<LanguageController>();

  @override
  void onInit() {
    precacheImage(
      const AssetImage('assets/animation/select_language.gif'),
      Get.context!,
    );
    super.onInit();
  }

  void changeLanguage(var isEnglish) {
    languageController.switchLanguage(isEnglish);

    final prefs = Get.find<SharedPreferences>();
    prefs.setBool('hasSelectedLanguage', true);

    Get.toNamed(Routes.firstOnBoarding);
  }
}
