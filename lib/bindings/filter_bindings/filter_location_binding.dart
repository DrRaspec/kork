part of '../../views/filter_views/filter_location.dart';

class FilterLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FilterLocationController(),
    );
  }
}
