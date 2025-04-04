part of 'my_event_detail_view.dart';

class MyEventDetailViewController extends GetxController {
  var argument = Get.arguments as HostedEvent;
  var title = ''.obs;
  final List<String> dots = ['.', '..', '...'];
  var total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // startLoadingAnimation();
    title.value = argument.eventName;
    total.value = argument.totalTicketValue;
  }

  // void startLoadingAnimation() {
  //   int index = 0;
  //   Timer.periodic(const Duration(milliseconds: 500), (timer) {
  //     title.value = dots[index];
  //     index = (index + 1) % dots.length;
  //   });
  // }

  void deleteEvent() async {
    try {
      const storage = FlutterSecureStorage();
      var id = await storage.read(key: 'id');
      var token = await storage.read(key: 'token');
      if (id == null || token == null) {
        Get.find<AuthService>().logout();
        return;
      }

      EventApiHelper.setToken(token);
      var response = await EventApiHelper.delete('/events/${argument.id}');
      if (response.statusCode == 204) {
        Get.snackbar('Success', 'Delete successful');
      }
    } on DioException catch (e) {
      var response = e.response;
      print(response?.data);
      print(response?.statusCode);
      Get.snackbar('Success', 'Delete fail');
    }
  }

  void openGmail() async {
    final Uri gmailAppUri = Uri.parse('googlegmail://');
    final Uri gmailWebUri = Uri.parse('https://mail.google.com');

    try {
      final bool canLaunchApp = await canLaunchUrl(gmailAppUri);

      if (canLaunchApp) {
        await launchUrl(gmailAppUri);
      } else {
        await launchUrl(
          gmailWebUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      print('Error launching Gmail: $e');
      await launchUrl(
        gmailWebUri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
