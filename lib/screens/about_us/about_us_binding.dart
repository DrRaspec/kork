part of 'about_us_view.dart';

class AboutUsViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => AboutUsViewController());
   }
}