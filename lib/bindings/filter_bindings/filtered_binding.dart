part of '../../views/filter_views/filtered_view.dart';

class FilteredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FilteredController(),
    );
  }
}
