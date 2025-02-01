part of '../views/event_view.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => EventController(),
    );
  }
}
