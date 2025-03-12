part of 'your_ticket_view.dart';

class YourTicketViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => YourTicketViewController());
  }
}
