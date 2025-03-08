part of 'add_new_payment_view.dart';

class AddNewPaymentViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => AddNewPaymentViewController());
   }
}