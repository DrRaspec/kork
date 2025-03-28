part of 'verify_otp_view.dart';

class VerifyOtpController extends GetxController {
  var isNew = Get.arguments as bool;

  final textFieldOne = TextEditingController();
  final textFieldTwo = TextEditingController();
  final textFieldThree = TextEditingController();
  final textFieldFour = TextEditingController();

  final focusNodeOne = FocusNode();
  final focusNodeTwo = FocusNode();
  final focusNodeThree = FocusNode();
  final focusNodeFour = FocusNode();

  var isEmpty = true.obs;

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
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
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
}
