part of '../views/sign_up_view/select_profile_view.dart';

class SelectProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SelectProfileController(),
    );
  }
}
