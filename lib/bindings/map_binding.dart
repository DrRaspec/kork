part of '../views/sign_up_view/map_view.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MapController(),
    );
  }
}
