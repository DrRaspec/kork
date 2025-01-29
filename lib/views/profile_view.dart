import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kork/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part '../controllers/profile_controller.dart';
part '../bindings/profile_binding.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 136,
                  height: 136,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Container(
                  width: 134,
                  height: 134,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/image/Artboard 1 2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.username,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 182,
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      size: 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      AppLocalizations.of(context)!.edit,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dlanguage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
              subtitle: Row(
                children: [
                  SvgPicture.asset(
                    'assets/image/svg/language-square.svg',
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Obx(
                    () => FlutterSwitch(
                      value: controller.isEnglish.value,
                      width: 40,
                      height: 20,
                      // valueFontSize: 10,
                      toggleSize: 16,
                      borderRadius: 100,
                      // padding: ,
                      showOnOff: false,
                      onToggle: controller.switchLanguage,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Setting',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            settingList(
              path: 'assets/image/svg/archive-minus.svg',
              text: AppLocalizations.of(context)!.bookmark,
            ),
            const SizedBox(height: 24),
            settingList(
              path: 'assets/image/svg/notification.svg',
              text: AppLocalizations.of(context)!.notification,
            ),
            const SizedBox(height: 24),
            settingList(
              path: 'assets/image/svg/card.svg',
              text: AppLocalizations.of(context)!.payment_method,
            ),
            const SizedBox(height: 24),
            settingList(
              path: 'assets/image/svg/copyright.svg',
              text: AppLocalizations.of(context)!.contact_us,
            ),
            const SizedBox(height: 24),
            settingList(
              path: 'assets/image/svg/user.svg',
              text: AppLocalizations.of(context)!.about_us,
            ),
          ],
        ),
      ),
    );
  }
}

Widget settingList({
  required String path,
  required String text,
}) {
  return Row(
    children: [
      SvgPicture.asset(
        path,
        width: 16,
        height: 16,
        colorFilter: ColorFilter.mode(
          Get.theme.colorScheme.tertiary,
          BlendMode.srcIn,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
      ),
      SvgPicture.asset(
        'assets/image/svg/arrow-right.svg',
        width: 16,
        height: 16,
        colorFilter: ColorFilter.mode(
          Get.theme.colorScheme.tertiary,
          BlendMode.srcIn,
        ),
      ),
    ],
  );
}
