part of 'see_all_view.dart';

class SeeAllViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => SeeAllViewController());
   }
}