part of 'event_member_view.dart';

class EventMemberViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventMemberController());
  }
}
