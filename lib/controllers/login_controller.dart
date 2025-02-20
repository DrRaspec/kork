part of '../views/login_view.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  var emailError = ''.obs;
  var passwordError = ''.obs;

  late AnimationController emailShakeController;
  late AnimationController passwordShakeController;
  late Animation<double> emailShakeAnimation;
  late Animation<double> passwordShakeAnimation;

  var passwordObsecure = true.obs;

  @override
  void onInit() {
    super.onInit();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    emailShakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    emailShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(emailShakeController);

    passwordShakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    passwordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(passwordShakeController);
  }

  void triggerEmailShake() {
    emailShakeController.forward(from: 0);
  }

  void triggerPasswordShake() {
    passwordShakeController.forward(from: 0);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailShakeController.dispose();
    passwordShakeController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  void validateInputs() {
    bool hasError = false;

    emailError.value = '';
    passwordError.value = '';

    if (emailController.text.isEmpty) {
      emailError.value =
          '${AppLocalizations.of(Get.context!)!.email_username}${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      triggerEmailShake();
    }

    if (passwordController.text.isEmpty) {
      passwordError.value =
          '${AppLocalizations.of(Get.context!)!.password}${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      triggerPasswordShake();
    }

    if (hasError) {
      Future.delayed(Duration.zero, () {
        if (emailError.isEmpty && passwordError.isNotEmpty) {
          passwordFocusNode.requestFocus();
        } else if (emailError.isNotEmpty) {
          emailFocusNode.requestFocus();
        }
      });
    }
  }
}
