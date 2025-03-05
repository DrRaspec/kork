part of 'forget_password_view.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ForgetPasswordController(),
    );
  }
}
