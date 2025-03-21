import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/main.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/button_design.dart';

part 'choose_language_binding.dart';
part 'choose_language_controller.dart';

class ChooseLanguageView extends GetView<ChooseLanguageViewController> {
  const ChooseLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    Get.isDarkMode
                        ? 'assets/image/logo.png'
                        : 'assets/image/light-logo.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.choose_your_language,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/animation/select_language.gif',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 22),
                GestureDetector(
                  onTap: () => controller.changeLanguage(false),
                  child: buttonDesign(
                    text: 'ភាសាខ្មែរ',
                    image: 'assets/image/flags/kh.svg',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.or,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => controller.changeLanguage(true),
                  child: buttonDesign(
                    text: 'English',
                    image: 'assets/image/flags/gb.svg',
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
