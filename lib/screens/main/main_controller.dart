part of 'main_view.dart';

class MainController extends GetxController {
  final apiService = Get.find<ApiService>();
  final authService = Get.find<AuthService>();
  final RxBool userDataReady = false.obs;
  final Rx<Map<String, dynamic>?> userData = Rx<Map<String, dynamic>?>(null);
  var currentIndex = 0.obs;
  var screens = [
    const HomeView(),
    const EventView(),
    const TicketView(),
    const ProfileView(),
  ].obs;

  @override
  void onInit() async {
    super.onInit();
    if (!await authService.isAuthenticated()) {
      Get.offAllNamed(Routes.login);
      return;
    }
    await fetchData();
  }

  Future<void> fetchData() async {
    try {
      final id = await Get.find<FlutterSecureStorage>().read(key: 'id');
      if (id != null) {
        userData.value = await apiService.getUserData(id);
        userDataReady.value = true;
        print('User data: $userData');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
