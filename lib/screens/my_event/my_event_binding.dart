part of 'my_event_view.dart';

class MyEventViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => MyEventViewController());
   }
}