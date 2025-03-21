import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

part 'contact_us_binding.dart';
part 'contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.contact_us),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.contact_us_via,
                style: TextStyle(
                  fontSize: 16,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Get.theme.colorScheme.surfaceTint),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: controller.openGmail,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/image/svg/Mail.svg',
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      Get.theme.colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'korkapp.team@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Get.theme.colorScheme.surfaceTint),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: controller.makePhoneCall,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/image/svg/Phone.svg',
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      Get.theme.colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '+855 96 270 654',
                    style: TextStyle(
                      fontSize: 14,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Get.theme.colorScheme.surfaceTint),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: controller.openTelegram,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/image/svg/Artboard.svg',
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      Get.theme.colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'YONG BUNLENG យ៉ង់ ប៊ុនឡេង',
                    style: TextStyle(
                      fontSize: 14,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Get.theme.colorScheme.surfaceTint),
          ],
        ),
      ),
    );
  }
}
