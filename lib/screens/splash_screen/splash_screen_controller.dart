part of 'splash_screen_view.dart';

class SplashScreenViewController extends GetxController {
  final SharedPreferences prefs;
  final _isNavigating = false.obs;

  SplashScreenViewController(this.prefs);

  @override
  void onInit() {
    super.onInit();
    initialNavigation();
  }

  void initialNavigation() {
    if (_isNavigating.value) return;

    _isNavigating.value = true;
    Future.delayed(
      const Duration(seconds: 2),
          () {
        final hasSelectedLanguage = prefs.getBool('hasSelectedLanguage') ?? false;
        if (!hasSelectedLanguage) {
          Get.offAllNamed(Routes.chooseLanguage);
          return;
        }

        final hasCompletedOnboarding =
            prefs.getBool('hasCompletedOnboarding') ?? false;
        if (!hasCompletedOnboarding) {
          Get.offAllNamed(Routes.firstOnBoarding);
        } else {
          final isLoggedIn = prefs.getBool('isLoggin') ?? false;
          Get.offAllNamed(isLoggedIn ? Routes.main : Routes.login);
        }
      },
    );
  }
}