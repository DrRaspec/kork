part of 'splash_screen_view.dart';

class SplashScreenViewController extends GetxController {
  late final SharedPreferences prefs;
  bool showMain = false;
  @override
  void onInit() async {
    super.onInit();
    await initialPrefs();
  }

  Future<void> initialPrefs() async {
    prefs = await SharedPreferences.getInstance();
    showMain = prefs.getBool('login') ?? false;
  }
}
