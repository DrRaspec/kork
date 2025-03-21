import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/main.dart';
import 'package:kork/screens/edit_profile/edit_profile_view.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'profile_change_password_binding.dart';
part 'profile_change_password_controller.dart';

class ProfileChangePasswordView
    extends GetView<ProfileChangePasswordViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: appbarTitle(AppLocalizations.of(context)!.change_password),
        actions: [
          IconButton(
            onPressed: Get.back,
            icon: SvgPicture.asset(
              'assets/image/svg/tag-cross.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(
                Get.theme.colorScheme.tertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  // Text(
                  //       controller.fullName,
                  //       style: TextStyle(
                  //         fontSize: 10,
                  //         color: Get.theme.colorScheme.tertiary,
                  //       ),
                  //     ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: controller.fullName,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          children: [
                            TextSpan(
                              text: ' .',
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        Get.isDarkMode
                            ? 'assets/image/logo.png'
                            : 'assets/image/light-logo.png',
                        width: 16,
                      ),
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            text: controller.languageCode.value == 'en'
                                ? AppLocalizations.of(context)!.kork
                                : AppLocalizations.of(context)!.app,
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.languageCode.value == 'en'
                                  ? Get.theme.colorScheme.primary
                                  : Get.theme.colorScheme.tertiary,
                            ),
                            children: [
                              const TextSpan(text: " "),
                              TextSpan(
                                text: controller.languageCode.value == 'en'
                                    ? AppLocalizations.of(context)!.app
                                    : AppLocalizations.of(context)!.kork,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: controller.languageCode.value == 'en'
                                      ? Get.theme.colorScheme.tertiary
                                      : Get.theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
