part of 'first_onboarding_view.dart';

class FirstOnboardingController extends GetxController {
  var indexScreen = 0.obs;
  var pageController = PageController();

  void nextPage() async {
    if (indexScreen.value < 2) {
      pageController.animateToPage(
        indexScreen.value + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('hasSelectedLanguage', true);
      prefs.setBool('hasCompletedOnboarding', true);
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
