part of 'profile_change_password_view.dart';

class ProfileChangePasswordViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ProfileChangePasswordViewController());
   }
}