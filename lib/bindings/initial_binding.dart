part of 'package:kork/main.dart';

class InitialBinding extends Bindings {
  final SharedPreferences prefs;

  InitialBinding(this.prefs);

  @override
  void dependencies() {
    // Get.put<ApiService>(ApiService(), permanent: true);
    // Get.lazyPut(() => HomeController(), fenix: true);
    // Get.lazyPut(() => EventController(), fenix: true);
    // Get.lazyPut(() => ProfileController(), fenix: true);
    // Get.lazyPut(() => TicketController(), fenix: true);

    // Get.lazyPut(() => AuthService(), fenix: true);
    // Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => const FlutterSecureStorage(), fenix: true);
    // Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => EventController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => TicketController(), fenix: true);
  }
}
