import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/my_event_option.dart';
import 'package:url_launcher/url_launcher.dart';

part 'my_event_detail_binding.dart';
part 'my_event_detail_controller.dart';

class MyEventDetailView extends GetView<MyEventDetailViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.update_event),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.myEventTicketDetail),
              child: myEventOption(
                text: AppLocalizations.of(context)!.ticket,
                icon: 'assets/image/svg/ticket.svg',
              ),
            ),
            const SizedBox(height: 8),
            myEventOption(
              text: AppLocalizations.of(context)!.total,
              icon: 'assets/image/svg/dollar-square.svg',
              customWidget: Text(
                '\$1290',
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.surfaceTint,
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: controller.openGmail,
              child: myEventOption(
                text: AppLocalizations.of(context)!.contact,
                notification: 100,
                icon: 'assets/image/svg/menu-board.svg',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.manage_event,
              style: TextStyle(
                fontSize: 16,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.updateEvent),
              child: myEventOption(
                text: AppLocalizations.of(context)!.update_event,
                icon: 'assets/image/svg/edit-2.svg',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                spacing: 16,
                children: [
                  SvgPicture.asset(
                    'assets/image/svg/delete.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Get.theme.colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.add_event,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: Color(0xffEAE9FC),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
