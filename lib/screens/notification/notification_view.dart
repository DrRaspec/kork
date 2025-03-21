import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'notification_binding.dart';
part 'notification_controller.dart';

class NotificationView extends GetView<NotificationViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.notification,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: ListView.separated(
          itemBuilder: (context, index) => notificationCard(),
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemCount: 4,
        ),
      ),
    );
  }
}

Widget notificationCard() {
  return Row(
    spacing: 16,
    children: [
      Image.asset(
        'assets/image/cambodia.png',
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Khmer New Year 2025',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            Text(
              'Hii!! I’m Scott, i Wanna ask You some more event',
              maxLines: 50,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 8,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            Text(
              '3h ago',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 8,
                color: Get.theme.colorScheme.surfaceTint,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
