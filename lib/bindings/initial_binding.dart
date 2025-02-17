part of 'package:kork/main.dart';

class InitialBinding extends Bindings {
  final SharedPreferences prefs;

  InitialBinding(this.prefs);

  @override
  void dependencies() {
    Get.put(ThemeController(prefs), permanent: true);
    Get.lazyPut(() => LanguageController(prefs), fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => EventController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => TicketController(), fenix: true);
  }
}
