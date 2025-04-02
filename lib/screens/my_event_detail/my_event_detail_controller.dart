part of 'my_event_detail_view.dart';

class MyEventDetailViewController extends GetxController {
  @override
  void onInit() {
    super.onInit();
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
