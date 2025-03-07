import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/button_design.dart';

part 'first_onboarding_binding.dart';
part 'first_onboarding_controller.dart';

class FirstOnboardingView extends GetView<FirstOnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Container(
                color: Colors.lightBlue,
                height: 530,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        children: [],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: controller.indexScreen.value == 0 ? 40 : 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: controller.indexScreen.value == 0
                                ? Get.theme.colorScheme.primary
                                : Get.theme.colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Container(
                          width: controller.indexScreen.value == 1 ? 40 : 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: controller.indexScreen.value == 1
                                ? Get.theme.colorScheme.primary
                                : Get.theme.colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Container(
                          width: controller.indexScreen.value == 2 ? 40 : 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: controller.indexScreen.value == 2
                                ? Get.theme.colorScheme.primary
                                : Get.theme.colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: buttonDesign(AppLocalizations.of(context)!.next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
