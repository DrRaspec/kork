import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kork/controllers/theme_controller.dart';
import 'package:kork/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/views/main_view.dart';

part '../../controllers/main_controller/profile_controller.dart';
part '../../bindings/main_binding/profile_binding.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        height: 248,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage(
                              'assets/image/android_gallery.png',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.blue.withOpacity(0.5),
                              BlendMode.overlay,
                            ),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 116,
                              height: 116,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Get.theme.colorScheme.tertiary,
                                  width: 1,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/image/android_gallery.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Get.theme.bottomNavigationBarTheme
                                        .backgroundColor,
                                    border: Border.all(
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    'assets/image/svg/edit-2.svg',
                                    width: 16,
                                    height: 16,
                                    colorFilter: ColorFilter.mode(
                                      Get.theme.colorScheme.tertiary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        AppLocalizations.of(context)!.username,
                        style: TextStyle(
                          fontSize: 20,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 36),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dlanguage,
                              style: TextStyle(
                                fontSize: 14,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/image/svg/language-square.svg',
                              colorFilter: ColorFilter.mode(
                                Get.theme.colorScheme.tertiary,
                                BlendMode.srcIn,
                              ),
                              width: 16,
                              height: 16,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.language,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            // const SizedBox(width: 12),
                            const Spacer(),
                            Obx(
                              () => Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      controller.isEnglish.value
                                          ? 'assets/image/uk.png'
                                          : 'assets/image/cambodia.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: FlutterSwitch(
                                  value: controller.isEnglish.value,
                                  width: 40,
                                  height: 24,
                                  // valueFontSize: 10,
                                  toggleSize: 18,
                                  borderRadius: 100,
                                  // padding: ,
                                  showOnOff: false,
                                  onToggle: controller.switchLanguage,
                                  activeColor: Colors.transparent,
                                  inactiveColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Setting',
                          style: TextStyle(
                            fontSize: 14,
                            color: Get.theme.colorScheme.tertiary,
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
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 17,
              left: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.profile,
                      style: TextStyle(
                        fontSize: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => IconButton(
                        onPressed: () {
                          Get.find<ThemeController>().toggleTheme();
                        },
                        icon: SvgPicture.asset(
                          Get.find<ThemeController>().currentThemeMode ==
                                  ThemeMode.dark
                              ? 'assets/image/svg/sun.svg'
                              : 'assets/image/svg/moon.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Get.theme.colorScheme.tertiary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
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
