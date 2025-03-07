import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/button_design.dart';
import 'package:kork/widget/on_boarding_widget/first_on_boarding.dart';
import 'package:kork/widget/on_boarding_widget/second_on_boarding.dart';
import 'package:kork/widget/on_boarding_widget/third_on_boarding.dart';

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
              SizedBox(
                height: 530,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        onPageChanged: (value) =>
                            controller.indexScreen.value = value,
                        children: [
                          firstOnBoarding(context),
                          secondOnBoarding(context),
                          thirdOnBoarding(context),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: controller.indexScreen.value == index
                                  ? 40
                                  : 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: controller.indexScreen.value == index
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: controller.nextPage,
                  child: buttonDesign(
                    text: controller.indexScreen.value == 2
                        ? AppLocalizations.of(context)!.get_started
                        : AppLocalizations.of(context)!.next,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
