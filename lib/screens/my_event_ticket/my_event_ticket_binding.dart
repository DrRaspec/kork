part of 'my_event_ticket_view.dart';

class MyEventTicketViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => MyEventTicketViewController());
   }
}