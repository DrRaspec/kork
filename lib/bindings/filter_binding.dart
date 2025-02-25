part of '../views/filter_view.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FilterController(),
    );
    Get.lazyPut(
      () => FilterLocationController(),
    );
  }
}
