part of 'checkout_view.dart';

class CheckoutController extends GetxController {
  var data = Get.arguments as EventDetailModel;
  var ticketQuantity = <int>[].obs;
  var total = 0.0.obs;
  var isExpand = false.obs;
  var discount = 0.0.obs;

  @override
  void onInit() {
    ticketQuantity.assignAll(List.generate(
      data.ticket.length,
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
      total.value += (ticketQuantity[i] * data.ticket[i]['price']);
    }
    print('total is: ${total.value}');
  }

  void toggleExpand() {
    isExpand.toggle();
  }

  void calculateDiscount() {
    
  }
}
