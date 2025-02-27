part of '../../views/sign_up_view/select_location_view.dart';

class SelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SelectLocationController(),
    );
    Get.lazyPut(
      () => MapController(),
    );
  }
}
