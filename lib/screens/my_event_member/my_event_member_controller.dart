part of 'my_event_member_view.dart';

class MyEventMemberViewController extends GetxController {
  var argument = Get.arguments as List;
  var ticketType = ''.obs;
  var attendees = <Attendee>[].obs;
  var ticketDetail = <TicketPurchase>[].obs;
  var matchAttendees = <Attendee>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    attendees.value = argument[0];
    ticketType.value = _capitalize(argument[1].toString());

    for (var attendee in attendees) {
      final ticket =
          getTicketPurchaseByType(attendee, ticketType.value.toLowerCase());
      if (ticket != null) {
        ticketDetail.add(ticket);
        matchAttendees.add(attendee);
      }
    }
  }

  TicketPurchase? getTicketPurchaseByType(Attendee attendee, String type) {
    switch (type) {
      case 'vvip':
        return attendee.vvip;
      case 'vip':
        return attendee.vip;
      case 'standard':
        return attendee.standard;
      case 'normal':
        return attendee.normal;
      default:
        return null;
    }
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();
}
