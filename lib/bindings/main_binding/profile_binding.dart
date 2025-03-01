part of '../../views/main_view/profile_view.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(),
    );
    Get.lazyPut(
      () => MainController(),
    );
  }
}
