part of 'home_view.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );
    Get.lazyPut(
      () => FilterController(),
    );
    Get.lazyPut(
      () => MainController(),
    );
  }
}
