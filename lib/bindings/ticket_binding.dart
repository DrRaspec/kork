part of '../views/ticket_view.dart';

class TicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TicketController(),
    );
  }
}
