part of 'map_view.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MapController(),
    );
  }
}
