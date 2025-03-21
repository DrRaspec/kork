part of 'contact_organizer_view.dart';

class ContactOrganizerController extends GetxController {
  var messageCtrl = TextEditingController();

  var isReport = Get.arguments as bool;

  @override
  void onInit() {
    super.onInit();
    print('is report value $isReport');
  }
}
