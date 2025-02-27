part of '../../views/sign_up_view/first_signup_view.dart';

class FirstSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FirstSignupController(),
    );
  }
}
