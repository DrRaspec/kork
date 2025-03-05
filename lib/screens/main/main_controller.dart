part of 'main_view.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var screen = [
    const HomeView(),
    const EventView(),
    const TicketView(),
    const ProfileView(),
  ].obs;
}
