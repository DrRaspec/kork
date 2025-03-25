part of 'your_ticket_view.dart';

class YourTicketViewController extends GetxController {
  var argument = Get.arguments as Event;
  final _currentIndex = 0.obs;
  late final List<String> imageList;
  @override
  void onInit() {
    super.onInit();
    imageList = List.generate(
      3,
      (index) {
        return argument.posterUrl;
      },
    );
  }

  void seeAllBookedEvent() {
    var mainIndex = Get.find<MainController>().currentIndex;
    mainIndex.value = 2;
    Get.offAllNamed(Routes.main);
  }
}
