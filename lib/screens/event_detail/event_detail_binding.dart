part of 'event_detail.dart';

class EventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => EventDetailController(),
    );
  }
}
