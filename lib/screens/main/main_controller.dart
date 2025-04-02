part of 'main_view.dart';

class MainController extends GetxController {
  final apiService = Get.find<ApiService>();
  final authService = Get.find<AuthService>();
  final RxBool userDataReady = false.obs;
  final RxBool isLoading = true.obs;
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
    try {
      isLoading.value = true;
      if (!await authService.isAuthenticated()) {
        Get.offAllNamed(Routes.login);
        return;
      }
      await fetchData();
    } catch (e) {
      // print('Error in MainController init: $e');
      Get.snackbar('Error', 'Failed to initialize app');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchData() async {
    try {
      final id = await Get.find<FlutterSecureStorage>().read(key: 'id');
      if (id == null) {
        await authService.logout();
        return;
      }

      userData.value = await apiService.getUserData(id);
      userDataReady.value = true;
    } catch (e) {
      // print('Error fetching user data: $e');
      Get.snackbar('Error', 'Failed to load user data');
      userDataReady.value = false;
    }
  }

  Future<void> refreshUserData() async {
    try {
      isLoading.value = true;
      userDataReady.value = false;
      await fetchData();
    } catch (e) {
      // print('Error refreshing user data: $e');
      Get.snackbar('Error', 'Failed to refresh user data');
    } finally {
      isLoading.value = false;
    }
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
