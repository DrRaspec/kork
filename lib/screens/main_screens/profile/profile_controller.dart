part of 'profile_view.dart';

class ProfileController extends GetxController {
  final languageController = Get.find<LanguageController>();
  final themeController = Get.find<ThemeController>();
  final mainController = Get.find<MainController>();
  var isEnglish = true.obs;
  late SharedPreferences prefs;
  var storage = const FlutterSecureStorage();
  var fullName = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var image = Rx<String?>(null);

  @override
  void onInit() async {
    super.onInit();
    isEnglish.value = languageController.isEnglish.value;

    languageController.isEnglish.listen((value) {
      isEnglish.value = value;
    });

    mainController.userData.listen((data) {
      if (data != null) {
        updateProfileInfo(data);
      }
    });
    if (mainController.userData.value != null) {
      updateProfileInfo(mainController.userData.value!);
    }

    prefs = await SharedPreferences.getInstance();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   getUserData();
  // }

  void switchLanguage(bool value) {
    if (isEnglish.value != value) {
      languageController.switchLanguage(value);
    }
  }

  void updateProfileInfo(Map<String, dynamic> data) {
    var userInfo = UserAccounts.fromMap(data);
    firstName.value = userInfo.firstName;
    lastName.value = userInfo.lastName;
    fullName.value = '${firstName.value} ${lastName.value}';
    image.value = userInfo.profileUrl;
    print('Profile image updated: ${image.value}');
  }

  void logout() async {
    prefs.setBool('isLoggin', false);
    await storage.write(key: 'token', value: null);
    await storage.write(key: 'id', value: null);
    var screenIndex = Get.find<MainController>().currentIndex;
    screenIndex.value = 0;
    Get.offAllNamed(Routes.login);
  }
}
