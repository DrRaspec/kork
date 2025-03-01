part of '../../views/main_view/profile_view.dart';

class ProfileController extends GetxController {
  final languageController = Get.find<LanguageController>();
  final themeController = Get.find<ThemeController>();
  var isEnglish = true.obs;

  @override
  void onInit() {
    super.onInit();
    isEnglish.value = languageController.isEnglish.value;
  }

  void switchLanguage(bool value) {
    isEnglish.value = value;
    languageController.switchLanguage(value);
  }
}
