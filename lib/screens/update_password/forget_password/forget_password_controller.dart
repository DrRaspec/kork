part of 'forget_password_view.dart';

class ForgetPasswordController extends GetxController
    with GetTickerProviderStateMixin {
  // final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var emailError = ''.obs;
  late FocusNode emailFocus;
  late AnimationController emailShakeController;
  late Animation<double> emailShakeAnimation;

  @override
  void onInit() {
    super.onInit();

    emailFocus = FocusNode();

    emailShakeController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    emailShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(emailShakeController);
  }

  @override
  void onClose() {
    emailController.dispose();
    emailShakeController.dispose();
    super.onClose();
  }

  void triggerShake() {
    emailShakeController.forward(from: 0);
  }

  void validateInput() {
    emailError.value = '';

    if (emailController.text.isEmpty) {
      emailError.value =
          '${AppLocalizations.of(Get.context!)!.email} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      triggerShake();
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(emailController.text.trim())) {
      emailError.value = AppLocalizations.of(Get.context!)!.invalid_email;
      triggerShake();
    }

    if (emailError.value.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        emailFocus.requestFocus();
      });
    }
  }

  Future<bool> sendOTP() async {
    try {
      var data = {"email": emailController.text};
      var response = await EventApiHelper.post('/send', data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      return false;
    }
  }

  void onTap() async {
    validateInput();
    var isSendOTP = await sendOTP();
    if (emailError.value.isEmpty && isSendOTP) {
      Get.toNamed(
        Routes.verifyOtp,
        arguments: {'isNew': false, 'email': emailController.text},
      );
    }
  }
}
