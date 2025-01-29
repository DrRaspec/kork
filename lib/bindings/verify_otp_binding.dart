part of '../views/verify_otp_view.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => VerifyOtpController(),
    );
  }
}
