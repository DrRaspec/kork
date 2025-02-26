part of '../views/forget_password_view/verify_otp_view.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => VerifyOtpController(),
    );
  }
}
