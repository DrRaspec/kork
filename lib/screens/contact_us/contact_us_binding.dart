part of 'contact_us_view.dart';

class ContactUsViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ContactUsViewController());
   }
}