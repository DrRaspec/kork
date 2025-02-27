part of '../views/search_event.dart';

class SearchEventController extends GetxController {
  var searchEvent = TextEditingController();

  @override
  void onClose() {
    searchEvent.dispose();
    super.onClose();
  }
}
