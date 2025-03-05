part of 'booked_event_detail_view.dart';

class BookedEventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BookedEventDetailController(),
    );
  }
}
