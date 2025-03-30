part of 'payment_methods_view.dart';

class PaymentMethodsViewController extends GetxController {
  var paymentMethod = <dynamic>[].obs;
  @override
  void onInit() {
    fetchPaymentMethod();
    super.onInit();
  }

  void fetchPaymentMethod() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');

    if (token == null || id == null) {
      await Get.find<AuthService>().logout();
      return;
    }

    try {
      PaymentMethodHelper.setToken(token);
      var response =
          await PaymentMethodHelper.get('/users/$id/payment-methods');
      if (response.statusCode == 200) {
        print('payment method data ${response.data['data']}');
        paymentMethod.assignAll(response.data['data']);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.response?.data);
      print(e.response?.statusCode);
    }
  }
}
