part of 'update_event_view.dart';

class UpdateEventViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => UpdateEventViewController());
   }
}