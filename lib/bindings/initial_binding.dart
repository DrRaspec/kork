part of 'package:kork/main.dart';

class InitialBinding extends Bindings {
  final SharedPreferences prefs;

  InitialBinding(this.prefs);
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController(prefs));
  }
}
