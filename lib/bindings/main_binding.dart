part of '../views/main_view.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MainController(),
    );
    Get.lazyPut(
      () => HomeController(),
    );
    Get.lazyPut(
      () => EventBinding(),
    );
    Get.lazyPut(
      () => ProfileBinding(),
    );
    Get.lazyPut(
      () => TicketBinding(),
    );
  }
}
