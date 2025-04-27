part of 'payment_methods_view.dart';

class PaymentMethodsViewController extends GetxController {
  var paymentMethod = <dynamic>[].obs;
  var status = Status.loading.obs;
  var isClickAble = true.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      var result = Get.arguments;
      if (result is bool) {
        isClickAble.value = result;
      }
    }
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
      status.value = Status.loading;
      var response =
          await PaymentMethodHelper.get('/users/$id/payment-methods');
      if (response.statusCode == 200) {
        status.value = Status.success;
        // print('payment method data ${response.data['data']}');
        paymentMethod.assignAll(response.data['data']);
      }
    } on DioException catch (e) {
      status.value = Status.error;
      print(e.message);
      print(e.response?.data);
      print(e.response?.statusCode);
    }
  }

  Future<void> deletePaymentMethod(int index, int paymentID) async {
    const storage = FlutterSecureStorage();
    var id = await storage.read(key: 'id');

    if (id == null) {
      await Get.find<AuthService>().logout();
      return;
    }

    try {
      var response = await PaymentMethodHelper.delete(
          '/users/$id/payment-methods/$paymentID');
      // print('status code ${response.statusCode}');
      if (response.statusCode == 200) {
        paymentMethod.removeAt(index);
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.response?.data);
      print(e.response?.statusCode);
    }
  }

  void reloadData() async {
    try {
      var result = await Get.toNamed(Routes.addNewPayment);
      // print('datatype result ${result.runtimeType}');
      // print('result $result');

      if (result is Map<String, dynamic> && result.isNotEmpty) {
        print('work');
        paymentMethod.add(result);
      }
    } catch (e) {
      print('error is $e');
    }
  }
}
