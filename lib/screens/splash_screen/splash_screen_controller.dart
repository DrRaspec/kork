part of 'splash_screen_view.dart';

class SplashScreenViewController extends GetxController {
  final SharedPreferences prefs;
  final _isNavigating = false.obs;

  var image = ''.obs;
  SplashScreenViewController(this.prefs);

  // @override
  // void onInit() {
  //   super.onInit();
  //   image.value = Get.isDarkMode
  //       ? 'assets/image/logo.png'
  //       : 'assets/image/light-logo.png';
  //   precacheImage(AssetImage(image.value), Get.context!);
  //   initialNavigation();
  // }

  @override
  void onInit() {
    super.onInit();
    image.value = Get.isDarkMode
        ? 'assets/image/logo.png'
        : 'assets/image/light-logo.png';
    precacheImage(AssetImage(image.value), Get.context!);

    // Remove the native splash to show our custom splash
    FlutterNativeSplash.remove();

    print("Splash screen timer started");

    // Use a different approach that's harder to interrupt
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        print("Splash screen timer about to complete");

        if (Get.currentRoute == Routes.splashScreen) {
          print("Still on splash screen, safe to navigate");
          final hasSelectedLanguage =
              prefs.getBool('hasSelectedLanguage') ?? false;
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
        } else {
          print("No longer on splash screen, skipping navigation");
        }
      });
    });
  }

  // void initialNavigation() {
  //   if (_isNavigating.value) return;

  //   _isNavigating.value = true;
  //   FlutterNativeSplash.remove();
  //   Future.delayed(
  //     const Duration(seconds: 50),
  //     () {
  //       final hasSelectedLanguage =
  //           prefs.getBool('hasSelectedLanguage') ?? false;
  //       if (!hasSelectedLanguage) {
  //         Get.offAllNamed(Routes.chooseLanguage);
  //         return;
  //       }

  //       final hasCompletedOnboarding =
  //           prefs.getBool('hasCompletedOnboarding') ?? false;
  //       if (!hasCompletedOnboarding) {
  //         Get.offAllNamed(Routes.firstOnBoarding);
  //       } else {
  //         final isLoggedIn = prefs.getBool('isLoggin') ?? false;
  //         Get.offAllNamed(isLoggedIn ? Routes.main : Routes.login);
  //       }
  //     },
  //   );
  // }
}
