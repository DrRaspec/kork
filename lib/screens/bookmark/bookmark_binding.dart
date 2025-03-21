part of 'bookmark_view.dart';

class BookmarkViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => BookmarkViewController());
   }
}