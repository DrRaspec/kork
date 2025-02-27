import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../../controllers/forget_password/forget_password_controller.dart';
part '../../bindings/forget_password/forget_password_binding.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 10) {
                Get.back();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      Image.asset(
                        Get.isDarkMode
                            ? 'assets/image/logo.png'
                            : 'assets/image/light-logo.png',
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          AppLocalizations.of(context)!.back,
                          style: TextStyle(
                            fontSize: 14,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      child: Text(
                        AppLocalizations.of(context)!.forget_your_password,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 177,
                      child: Text(
                        AppLocalizations.of(context)!
                            .forget_your_password_guide,
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.surfaceTint,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.email_username,
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  AnimatedBuilder(
                    animation: controller.emailShakeAnimation,
                    builder: (context, child) {
                      final double shakeOffset =
                          sin(controller.emailShakeAnimation.value * pi * 2) *
                              5;
                      return Transform.translate(
                        offset: Offset(shakeOffset, 0),
                        child: SizedBox(
                          height: 40,
                          child: Obx(
                            () => TextField(
                              controller: controller.emailController,
                              textAlignVertical: TextAlignVertical.center,
                              focusNode: controller.emailFocus,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(10),
                                hintText: controller.emailError.value.isEmpty
                                    ? 'example@gmail.com'
                                    : controller.emailError.value,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: controller.emailError.value.isEmpty
                                      ? Get.theme.colorScheme.surfaceTint
                                      : Get.theme.colorScheme.primary,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: controller.emailError.value.isEmpty
                                        ? Get.theme.colorScheme.tertiary
                                        : Get.theme.colorScheme.primary,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: controller.emailError.value.isEmpty
                                        ? Get.theme.colorScheme.tertiary
                                        : Get.theme.colorScheme.primary,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: controller.emailError.value.isEmpty
                                        ? Get.theme.colorScheme.tertiary
                                        : Get.theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.back_to_signin,
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Get.offNamedUntil(
                          Routes.login,
                          (route) => false,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.signin,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xffC9131E),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      controller.validateInput();
                      if (controller.emailError.value.isEmpty) {
                        Get.toNamed(Routes.verifyOtp);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Get.theme.colorScheme.primary,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.next,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xffEAE9FC),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
