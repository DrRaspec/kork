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

  @override
  void onClose() {
    textFieldOne.dispose();
    textFieldTwo.dispose();
    textFieldThree.dispose();
    textFieldFour.dispose();
    focusNodeOne.dispose();
    focusNodeTwo.dispose();
    focusNodeThree.dispose();
    focusNodeFour.dispose();
    super.onClose();
  }

  void validateInput() {
    if (textFieldOne.text.isEmpty) {
      focusNodeOne.requestFocus();
      isEmpty.value = false;
    } else if (textFieldTwo.text.isEmpty) {
      focusNodeTwo.requestFocus();
      isEmpty.value = false;
    } else if (textFieldThree.text.isEmpty) {
      focusNodeThree.requestFocus();
      isEmpty.value = false;
    } else if (textFieldFour.text.isEmpty) {
      focusNodeFour.requestFocus();
      isEmpty.value = false;
    } else {
      isEmpty.value = true;
    }
  }
}
