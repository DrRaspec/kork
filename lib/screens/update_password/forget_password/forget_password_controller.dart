part of 'forget_password_view.dart';

class ForgetPasswordController extends GetxController
    with GetTickerProviderStateMixin {
  // final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var emailError = ''.obs;
  late FocusNode emailFocus;
  late AnimationController emailShakeController;
  late Animation<double> emailShakeAnimation;
  var status = Status.success.obs;
  bool canSendOTP = true;

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

  Future<bool> checkEmail() async {
    try {
      var body = {'email': emailController.text};
      var response = await EventApiHelper.post(
        '/check-email',
        data: body,
      );

      // If we get a standard success response, it means the email doesn't exist
      Get.snackbar(
          "Error", "This email is not registered. Please sign up first.");
      return false;
    } on DioException catch (e) {
      var response = e.response;

      // 409 means email exists, which is what we want for password reset
      if (response?.statusCode == 409) {
        return true;
      } else {
        var data = response?.data;
        String errorMessage = "Email check failed";

        if (data != null && data is Map && data.containsKey('email')) {
          errorMessage = data['email'].toString();
        }

        Get.snackbar("Fail", errorMessage);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred");
      return false;
    }
  }

  // Future<bool> sendOTP() async {
  //   if (!canSendOTP) {
  //     Get.snackbar("Please wait", "You can request another OTP shortly");
  //     return false;
  //   }
  //
  //   try {
  //     var body = {"email": emailController.text};
  //     var response = await EventApiHelper.post("/send", data: body);
  //     if (response.statusCode == 200) {
  //       canSendOTP = false;
  //       Future.delayed(const Duration(minutes: 1), () {
  //         canSendOTP = true;
  //       });
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on DioException catch (e) {
  //     var response = e.response;
  //
  //     // Specifically handle 429 errors
  //     if (response?.statusCode == 429) {
  //       Get.snackbar(
  //         'Rate Limited',
  //         'Too many OTP requests. Please try again later.',
  //       );
  //       // Set a longer cooldown when rate limited by server
  //       canSendOTP = false;
  //       Future.delayed(const Duration(minutes: 5), () {
  //         canSendOTP = true;
  //       });
  //     } else {
  //       Get.snackbar(
  //         'Fail',
  //         response == null ? 'Failed to send OTP' : response.data['message'],
  //       );
  //     }
  //     return false;
  //   }
  // }

  void onTap() async {
    if (status.value == Status.loading) return;
    validateInput();
    if (emailError.value.isNotEmpty) return;
    status.value = Status.loading;

    final isEmailExist = await checkEmail();
    if (!isEmailExist) {
      status.value = Status.error;
      Get.snackbar(
          "Error", "Email not found. Please check your email address.");
      return;
    }

    await Future.delayed(const Duration(seconds: 1));

    if (!canSendOTP) {
      status.value = Status.success;
      Get.snackbar("Please wait", "You can request another OTP shortly");
      return;
    }

    // Get.snackbar("Verified", "Email verified. Sending OTP...");
    final isSendOTP = await sendOTP(
      canSendOTP: canSendOTP,
      email: emailController.text,
    );
    if (isSendOTP) {
      status.value = Status.success;
      Get.toNamed(
        Routes.verifyOtp,
        arguments: {'isNew': false, 'email': emailController.text},
      );
    } else {
      status.value = Status.error;
      Get.snackbar("Error", "Failed to send OTP. Please try again.");
    }
  }
}
