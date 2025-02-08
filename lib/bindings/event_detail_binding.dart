part of '../views/event_detail.dart';

class EventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => EventDetailController(),
    );
  }
}
