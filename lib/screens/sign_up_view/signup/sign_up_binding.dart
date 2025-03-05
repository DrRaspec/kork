part of 'sign_up_view.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignUpController(),
    );
    // Get.lazyPut(
    //   () => VerifyOtpController(),
    // );
  }
}
