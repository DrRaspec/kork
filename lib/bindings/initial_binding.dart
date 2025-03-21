part of 'package:kork/main.dart';

class InitialBinding extends Bindings {
  final SharedPreferences prefs;

  InitialBinding(this.prefs);

  @override
  void dependencies() {
    // Get.put(ThemeController(prefs), permanent: true);
    // Get.put(ThemeController(prefs), permanent: true);
    // Get.put(LanguageController(prefs), permanent: true);
    // Get.put(MainController(), permanent: true);

    // // Get.lazyPut(() => LanguageController(prefs), fenix: true);
    // // Get.lazyPut(() => MainController(), fenix: true);
    // Get.lazyPut(() => HomeController(), fenix: true);
    // Get.lazyPut(() => EventController(), fenix: true);
    // Get.lazyPut(() => ProfileController(), fenix: true);
    // Get.lazyPut(() => TicketController(), fenix: true);
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => EventController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => TicketController(), fenix: true);
  }
}
