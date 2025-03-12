part of 'add_event_view.dart';

class AddEventViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => AddEventViewController());
   }
}