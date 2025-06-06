part of 'verify_otp_view.dart';

class VerifyOtpController extends GetxController {
  var argument = Get.arguments as Map<String, dynamic>;
  var isNew = false;
  var email = '';
  var status = Status.success.obs;

  final textFieldOne = TextEditingController();
  final textFieldTwo = TextEditingController();
  final textFieldThree = TextEditingController();
  final textFieldFour = TextEditingController();

  final focusNodeOne = FocusNode();
  final focusNodeTwo = FocusNode();
  final focusNodeThree = FocusNode();
  final focusNodeFour = FocusNode();

  var isEmpty = true.obs;

  var canSendOTP = true.obs;
  Timer? _otpTimer;

  List<TextEditingController> get otpControllers => [
        textFieldOne,
        textFieldTwo,
        textFieldThree,
        textFieldFour,
      ];

  List<FocusNode> get otpFocusNodes => [
        focusNodeOne,
        focusNodeTwo,
        focusNodeThree,
        focusNodeFour,
      ];

  @override
  void onInit() {
    isNew = argument['isNew'];
    email = argument['email'];
    print('verify otp receive email $email');
    super.onInit();
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    _otpTimer?.cancel();
    super.onClose();
  }

  String get otp {
    return textFieldOne.text +
        textFieldTwo.text +
        textFieldThree.text +
        textFieldFour.text;
  }

  void validateInput() {
    for (int i = 0; i < otpControllers.length; i++) {
      if (otpControllers[i].text.isEmpty) {
        otpFocusNodes[i].requestFocus();
        isEmpty.value = false;
        return;
      }
    }
    isEmpty.value = true;
  }

  Future<bool> checkOTP() async {
    try {
      status.value = Status.loading;
      var formData = FormData.fromMap(
        {'email': email, 'code': otp},
      );
      // {'email', email, '', otp};
      var response = await EventApiHelper.post(
        '/verify',
        data: formData,
      );
      if (response.statusCode == 200) {
        status.value = Status.success;
        return true;
      } else {
        status.value = Status.error;
        return false;
      }
    } on DioException catch (e) {
      status.value = Status.error;
      var response = e.response;
      var data = response?.data as Map<String, dynamic>;
      Get.snackbar(
        'Fail',
        response == null
            ? 'Fail to check OTP'
            : data.containsKey('error')
                ? data['error']
                : data['message'],
      );
      return false;
    }
  }

  void onTapVerifyOTP() async {
    validateInput();
    var isCorrectOTP = await checkOTP();
    if (isEmpty.value && isCorrectOTP) {
      if (isNew) {
        Get.toNamed(Routes.selectProfile);
      } else {
        Get.toNamed(
          Routes.changePassword,
          arguments: {'code': otp, 'email': email},
        );
      }
    }
  }

  void resendOTP() async {
    if (!canSendOTP.value) return;

    canSendOTP.value = false;

    final isSendOTP = await sendOTP(
      canSendOTP: canSendOTP.value,
      email: email,
      isRegister: false,
    );

    if (isSendOTP) {
      startOTPTimer();
    } else {
      canSendOTP.value = true;
    }
  }

  void startOTPTimer() {
    _otpTimer?.cancel();

    _otpTimer = Timer(const Duration(minutes: 5), () {
      canSendOTP.value = true;
    });
  }
}
