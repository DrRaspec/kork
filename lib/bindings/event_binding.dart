part of '../views/event_view.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MainController(),
    );
    Get.lazyPut(
      () => EventController(),
    );
  }
}
