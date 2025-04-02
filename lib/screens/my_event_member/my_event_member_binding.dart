part of 'my_event_member_view.dart';

class MyEventMemberViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => MyEventMemberViewController());
   }
}