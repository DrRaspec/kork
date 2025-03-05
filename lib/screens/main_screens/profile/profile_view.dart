import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kork/controllers/theme_controller.dart';
import 'package:kork/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/widget/setting_list.dart';

part 'profile_controller.dart';
part 'profile_binding.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 248,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/image/cambodia.png',
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            Positioned.fill(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                            ),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 116,
                                    height: 116,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xffEAE9FC),
                                        width: 3,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/image/cambodia.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 10,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Get
                                              .theme
                                              .bottomNavigationBarTheme
                                              .backgroundColor,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
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
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                            const SizedBox(height: 19),
                            settingList(
                              path: 'assets/image/svg/notification.svg',
                              text: AppLocalizations.of(context)!.notification,
                              notificationNum: 100,
                            ),
                            const SizedBox(height: 19),
                            settingList(
                              path: 'assets/image/svg/card.svg',
                              text:
                                  AppLocalizations.of(context)!.payment_method,
                            ),
                            const SizedBox(height: 24),
                            settingList(
                              path: 'assets/image/svg/ticket-star.svg',
                              text: AppLocalizations.of(context)!.my_event,
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
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 7,
                left: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.profile,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xffEAE9FC),
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
                            colorFilter: const ColorFilter.mode(
                              Color(0xffEAE9FC),
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
      ),
    );
  }
}
