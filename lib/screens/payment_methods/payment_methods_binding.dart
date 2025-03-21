part of 'payment_methods_view.dart';

class PaymentMethodsViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => PaymentMethodsViewController());
   }
}