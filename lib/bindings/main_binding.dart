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
  }
}
