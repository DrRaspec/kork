part of '../views/forget_password_view/forget_password_view.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ForgetPasswordController(),
    );
  }
}
