part of 'my_event_detail_view.dart';

class MyEventDetailViewController extends GetxController {
  var argument = Get.arguments as HostedEvent;
  var title = ''.obs;
  final List<String> dots = ['.', '..', '...'];
  var total = 0.0.obs;
  var status = Status.none;

  @override
  void onInit() {
    super.onInit();
    title.value = argument.eventName;
    total.value = argument.totalTicketValue;
  }

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
        Get.back();
        Get.snackbar(
          'Success',
          'Event deleted successfully',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } on DioException catch (e) {
      var response = e.response;

      if (response != null &&
          response.statusCode == 500 &&
          response.data != null &&
          response.data is Map<String, dynamic> &&
          response.data['message'] != null &&
          response.data['message']
              .toString()
              .contains('foreign key constraint fails')) {
        // First close the dialog, then show snackbar
        Get.back();
        Get.snackbar(
          'Cannot Delete Event',
          'This event can\'t be deleted because users have already bought tickets.',
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.TOP,
        );
      } else {
        // First close the dialog, then show snackbar
        Get.back();
        Get.snackbar(
          'Error',
          'Failed to delete event. Please try again later.',
          backgroundColor: Colors.orange[100],
          colorText: Colors.orange[900],
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
      print(response?.data);
      print(response?.statusCode);
    }
  }

  void onDeleteEvent(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text(
          'Are you sure you want to delete this event?',
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: deleteEvent,
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
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
