part of 'checkout_view.dart';

class CheckoutController extends GetxController {
  var data = Get.arguments as Event;
  var ticketQuantity = <int>[].obs;
  var total = 0.0.obs;
  var isExpand = false.obs;
  var discountPrice = 0.0.obs;
  var boughtTicket = <dynamic>[].obs;

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
    total(0);
    for (int i = 0; i < ticketQuantity.length; i++) {
      total.value += (ticketQuantity[i] * data.tickets[i].price);
    }
    print('total is: ${total.value}');
  }

  void toggleExpand() {
    isExpand.toggle();
  }

  void buyTicket() async {
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

  void calculateDiscount() {}
}
