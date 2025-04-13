part of 'my_event_ticket_view.dart';

class MyEventTicketViewController extends GetxController {
  var selectedIndex = 0.obs;
  // var eventTicketType = [
  //   AppLocalizations.of(Get.context!)!.normal,
  //   AppLocalizations.of(Get.context!)!.standard,
  //   'VIP',
  //   'VVIP',
  // ];
  var argument = Get.arguments as HostedEvent;
  var tickets = [].obs;
  var ticketAvailable = 0.obs;
  var ticketSold = 0.obs;

  @override
  void onInit() {
    super.onInit();
    parseTickets();
  }

  void parseTickets() {
    tickets.value = argument.tickets
        .map(
          (e) => e,
        )
        .toList();

    ticketAvailable.value = tickets.fold(
      0,
      (previousValue, element) {
        element as Ticket;
        return previousValue + element.availableQty;
      },
    );

    ticketSold.value = tickets.fold(
      0,
      (previousValue, element) {
        element as Ticket;
        return previousValue + element.soldQty;
      },
    );
  }
}
