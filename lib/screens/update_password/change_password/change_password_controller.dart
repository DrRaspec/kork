part of 'change_password_view.dart';

class ChangePasswordController extends GetxController
    with GetTickerProviderStateMixin {
  final newPassword = TextEditingController();
  final conNewPassword = TextEditingController();

  var passwordObsecure = true.obs;
  var passwordError = ''.obs;
  late FocusNode passwordFocus;
  late AnimationController passwordShakeController;
  late Animation<double> passwordShakeAnimation;

  var conPasswordObsecure = true.obs;
  var conPasswordError = ''.obs;
  late FocusNode conPasswordFocus;
  late AnimationController conPasswordShakeController;
  late Animation<double> conPasswordShakeAnimation;

  @override
  void onInit() {
    super.onInit();

    passwordFocus = FocusNode();
    conPasswordFocus = FocusNode();

    passwordShakeController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    passwordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(passwordShakeController);

    conPasswordFocus = FocusNode();

    conPasswordShakeController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    conPasswordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(conPasswordShakeController);
  }

  @override
  void onClose() {
    newPassword.dispose();
    passwordShakeController.dispose();
    passwordFocus.dispose();
    conNewPassword.dispose();
    conPasswordFocus.dispose();
    conPasswordShakeController.dispose();
    super.onClose();
  }

  void trigglePasswordShake() {
    passwordShakeController.forward(from: 0);
  }

  void triggleConPasswordShake() {
    conPasswordShakeController.forward(from: 0);
  }

  void validateInput() {
    passwordError.value = '';
    conPasswordError.value = '';
    var hasError = false;

    if (newPassword.text.isEmpty) {
      passwordError.value =
          '${AppLocalizations.of(Get.context!)!.password} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      trigglePasswordShake();
      hasError = true;
    } else if (newPassword.text.length < 8 ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(newPassword.text)) {
      passwordError.value = AppLocalizations.of(Get.context!)!.password_quide;
      trigglePasswordShake();
      hasError = true;
    }
    if (conNewPassword.text.isEmpty) {
      conPasswordError.value =
          '${AppLocalizations.of(Get.context!)!.password} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      triggleConPasswordShake();
      hasError = true;
    } else if (conNewPassword.text.length < 8 ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(conNewPassword.text)) {
      conPasswordError.value =
          AppLocalizations.of(Get.context!)!.password_quide;
      triggleConPasswordShake();
      hasError = true;
    } else if (conNewPassword.text != newPassword.text) {
      conPasswordError.value =
          AppLocalizations.of(Get.context!)!.password_not_match;
      triggleConPasswordShake();
      hasError = true;
    }

    if (hasError) {
      Future.delayed(Duration.zero, () {
        if (passwordError.isNotEmpty) {
          passwordFocus.requestFocus();
        } else if (conPasswordError.isNotEmpty) {
          conPasswordFocus.requestFocus();
        }
      });
    }
  }
}
