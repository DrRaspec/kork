part of 'contact_organizer_view.dart';

class ContactOrganizerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactOrganizerController());
  }
}
