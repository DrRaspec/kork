// part of 'profile_view.dart';

// class ProfileController extends GetxController {
//   final languageController = Get.find<LanguageController>();
//   // late final LanguageController languageController;
//   final themeController = Get.find<ThemeController>();
//   var isEnglish = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     isEnglish.value = languageController.isEnglish.value;
//   }

//   void switchLanguage(bool value) {
//     isEnglish.value = value;
//     languageController.switchLanguage(value);
//   }
// }

part of 'profile_view.dart';

class ProfileController extends GetxController {
  final languageController = Get.find<LanguageController>();
  final themeController = Get.find<ThemeController>();
  var isEnglish = true.obs;

  @override
  void onInit() {
    super.onInit();
    isEnglish.value = languageController.isEnglish.value;

    // Add this to keep the switch in sync with the actual language state
    languageController.isEnglish.listen((value) {
      isEnglish.value = value;
    });
  }

  void switchLanguage(bool value) {
    // Only call the language controller if the value actually changed
    if (isEnglish.value != value) {
      languageController.switchLanguage(value);
    }
  }
}
