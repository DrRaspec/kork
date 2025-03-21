part of 'my_event_detail_view.dart';

class MyEventDetailViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => MyEventDetailViewController());
   }
}