part of '../views/first_signup_view.dart';

class FirstSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FirstSignupController(),
    );
  }
}
