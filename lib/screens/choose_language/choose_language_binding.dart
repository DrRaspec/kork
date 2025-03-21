part of 'choose_language_view.dart';

class ChooseLanguageViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => ChooseLanguageViewController());
   }
}