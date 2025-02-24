part of '../views/select_location_view.dart';

class SelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SelectLocationController(),
    );
  }
}
