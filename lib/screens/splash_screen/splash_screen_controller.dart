part of 'splash_screen_view.dart';

class SplashScreenViewController extends GetxController {
  late final SharedPreferences prefs;
  bool isLoggedIn = false;

  void initialNavigation() {
    Future.delayed(
      const Duration(seconds: 2),
      () => navigateToNextScreen(),
    );
  }

  Future<void> navigateToNextScreen() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggin') ?? false;
    final bool hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;
    if (!hasCompletedOnboarding) {
      Get.offAllNamed(Routes.firstOnBoarding);
    } else if (isLoggedIn) {
      Get.offAllNamed(Routes.main);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
