part of '../../views/forget_password_view/change_password_view.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChangePasswordController(),
    );
  }
}
