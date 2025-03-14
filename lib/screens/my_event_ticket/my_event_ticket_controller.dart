part of 'my_event_ticket_view.dart';

class MyEventTicketViewController extends GetxController {
  var selectedIndex = 0.obs;
  var eventTicketType = [
    AppLocalizations.of(Get.context!)!.normal,
    AppLocalizations.of(Get.context!)!.standard,
    'VIP',
    'VVIP',
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
