part of 'contact_us_view.dart';

class ContactUsViewController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> openGmail() async {
    const String email = 'korkapp.team@gmail.com';

    try {
      if (GetPlatform.isAndroid) {
        final Uri gmailUri =
            Uri.parse('content://com.google.android.gm.provider');
        if (await canLaunchUrl(gmailUri)) {
          final Uri mailtoUri = Uri.parse('mailto:$email');
          await launchUrl(mailtoUri, mode: LaunchMode.platformDefault);
          return;
        }
      }

      if (GetPlatform.isAndroid) {
        final Uri intentUri =
            Uri.parse('intent:#Intent;action=android.intent.action.SENDTO;'
                'data=mailto:$email;'
                'package=com.google.android.gm;'
                'end');
        if (await canLaunchUrl(intentUri)) {
          await launchUrl(intentUri);
          return;
        }
      }

      final Uri mailtoUri = Uri.parse('mailto:$email');
      if (await canLaunchUrl(mailtoUri)) {
        await launchUrl(mailtoUri, mode: LaunchMode.platformDefault);
      } else {
        final Uri gmailWebUri =
            Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=$email');
        await launchUrl(
          gmailWebUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      print('Error launching email app: $e');
      Get.snackbar(
        'Error',
        'Could not open email application',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> makePhoneCall() async {
    const String phoneNumber = '+85561214642';
    final Uri callUri = Uri.parse('tel:$phoneNumber');

    try {
      if (GetPlatform.isAndroid) {
        // Android-specific permission handling
        bool hasPermission = await Permission.phone.request().isGranted;
        if (!hasPermission) {
          Get.snackbar(
            'Permission Denied',
            'Please grant phone call permission in app settings',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }

      // For both iOS and Android
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        print('Could not launch $callUri');
        Get.snackbar(
          'Error',
          'Could not open phone dialer',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error making phone call: $e');
      Get.snackbar(
        'Error',
        'Could not make phone call: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> openTelegram() async {
    try {
      Uri telegramUri = Uri.parse('tg://resolve?domain=@bunleng369');

      if (await canLaunchUrl(telegramUri)) {
        launchUrl(telegramUri);
      } else {
        Uri webUri = Uri.parse('https://t.me/bunleng369');
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri, mode: LaunchMode.externalApplication);
        } else {
          print('Could not launch Telegram');
          Get.snackbar(
            'Error',
            'Could not open Telegram',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      print('Error opening Telegram: $e');
      Get.snackbar(
        'Error',
        'Could not open Telegram: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
