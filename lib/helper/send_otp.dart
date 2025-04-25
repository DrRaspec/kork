import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kork/helper/event_api_helper.dart';

Future<bool> sendOTP({
  required bool canSendOTP,
  required String email,
  bool isRegister = true,
}) async {
  if (!canSendOTP) {
    Get.snackbar("Please wait", "You can request another OTP shortly");
    return false;
  }

  try {
    var body = {"email": email};
    var endpoint = isRegister ? "/send" : '/send-reset';
    var response = await EventApiHelper.post(endpoint, data: body);
    if (response.statusCode == 200) {
      canSendOTP = false;
      Future.delayed(const Duration(minutes: 1), () {
        canSendOTP = true;
      });
      return true;
    } else {
      return false;
    }
  } on DioException catch (e) {
    var response = e.response;
    Get.snackbar(
      'Fail',
      response == null ? 'fail to send OTP' : response.data['message'],
    );
    return false;
  }
}
