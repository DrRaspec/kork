part of '../views/profile_view.dart';

class ProfileController extends GetxController {
  final languageController = Get.find<LanguageController>();
  var isEnglish = true.obs;

  @override
  void onInit() {
    super.onInit();
    isEnglish = languageController.isEnglish;
  }

  void switchLanguage(bool value) {
    isEnglish.value = value;
    languageController.switchLanguage(value);
  }
}
