part of 'checkout_view.dart';

class CheckoutController extends GetxController {
  var data = Get.arguments as Event;
  var ticketQuantity = <int>[].obs;
  var total = 0.0.obs;
  var isExpand = false.obs;
  var discountPrice = 0.0.obs;
  var boughtTicket = <dynamic>[].obs;
  var paymentStatus = false;
  var feePercent = 10.0;

  @override
  void onInit() {
    ticketQuantity.assignAll(List.generate(
      data.tickets.length,
      (index) => 0,
    ));
    super.onInit();
  }

  void increaseQuantity(int index) {
    ticketQuantity[index] += 1;
    calculateTotal();
  }

  void decreaseQuantity(int index) {
    if (ticketQuantity[index] > 0) {
      ticketQuantity[index] -= 1;
      calculateTotal();
    }
  }

  void calculateTotal() {
    double subtotal = 0.0;
    for (int i = 0; i < ticketQuantity.length; i++) {
      subtotal += (ticketQuantity[i] * data.tickets[i].price);
    }
    total.value = (subtotal - discountPrice.value).roundToDouble();
    total.value = (total.value * (1 + feePercent / 100)).roundToDouble();
    print('total is: ${total.value}');
  }

  void toggleExpand() {
    isExpand.toggle();
  }

  void buyTicket() async {
    if (paymentStatus == false) {
      Get.snackbar('Error', 'Please add payment method');
      return;
    }
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var id = data.id;

    if (token == null) {
      await Get.find<AuthService>().logout();
      return;
    }

    try {
      EventApiHelper.setToken(token);
      var formData = FormData();

      int validTicketIndex = 0;

      for (var i = 0; i < data.tickets.length; i++) {
        if (ticketQuantity[i] > 0) {
          formData.fields.addAll([
            MapEntry('tickets[$validTicketIndex][ticket_id]',
                data.tickets[i].id.toString()),
            MapEntry('tickets[$validTicketIndex][qty]',
                ticketQuantity[i].toString()),
          ]);
          validTicketIndex++;
        }
      }

      formData.fields.add(MapEntry('payment_status', paymentStatus.toString()));

      if (validTicketIndex == 0) {
        Get.snackbar('Error', 'Please select at least one ticket');
        return;
      }

      var response =
          await EventApiHelper.post('/events/$id/buy-tickets', data: formData);

      if (response.statusCode == 200) {
        boughtTicket.assignAll(response.data);
        Get.snackbar('Success', 'Tickets purchased successfully');
        Get.toNamed(
          Routes.yourTicket,
          arguments: data,
        );
      }
    } on DioException catch (e) {
      print(e.message);
      print(e.response?.data);
      print(e.response?.statusCode);
      Get.snackbar(
          'Error', e.response?.data['message'] ?? 'Failed to purchase tickets');
    }
  }

  void selectPaymentMethod() async {
    var result = await Get.toNamed(Routes.paymentMethod);
    if (result == true) {
      paymentStatus = true;
    }
  }

  void calculateDiscount() async {
    var result = await Get.toNamed(Routes.applyCoupon);
    // var applyCouponController = Get.find<ApplyCouponViewController>();
    if (result != null) {
      var discountPercent = result / 100;
      discountPrice.value = (total.value * discountPercent).roundToDouble();
      calculateTotal();
    }
  }
}
