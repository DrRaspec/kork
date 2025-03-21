part of 'profile_change_password_view.dart';

class ProfileChangePasswordViewController extends GetxController {
  var editProfileController = Get.find<EditProfileViewController>();
  late String fullName;
  Rx<String> languageCode =
      Get.find<LanguageController>().currentLocale.languageCode.obs;

  @override
  void onInit() {
    super.onInit();
    fullName = editProfileController.fullName.value;
  }
}
