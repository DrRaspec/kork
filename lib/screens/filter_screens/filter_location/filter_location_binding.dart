part of 'filter_location.dart';

class FilterLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FilterLocationController(),
    );
  }
}
