part of 'your_ticket_view.dart';

class YourTicketViewController extends GetxController {
  var argument = Get.arguments as EventDetailModel;
  var _currentIndex = 0.obs;
  late final List<String> imageList;
  @override
  void onInit() {
    super.onInit();
    imageList = List.generate(
      3,
      (index) {
        return 'assets/images/anime_cover.jpg';
      },
    );
  }
}
