part of '../views/search_event.dart';

class SearchEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchEventController());
  }
}
