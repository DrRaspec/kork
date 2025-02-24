import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../controllers/sign_up_controller.dart';
part '../bindings/sign_up_binding.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              // vertical: 17,
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
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.sign_up,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.email,
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
                        sin(controller.emailShakeAnimation.value * pi * 2) * 5;
                    return Transform.translate(
                      offset: Offset(shakeOffset, 0),
                      child: SizedBox(
                        height: 40,
                        child: Obx(
                          () => TextField(
                            controller: controller.emailController,
                            focusNode: controller.emailFocus,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              controller.emailError.value = '';
                            },
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            decoration: InputDecoration(
                              // alignLabelWithHint: true,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              hintText: 'example@gmail.com',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: controller.emailError.isNotEmpty
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.surfaceTint,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: controller.emailError.isNotEmpty
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.tertiary,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: controller.emailError.isNotEmpty
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.tertiary,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Obx(
                  () => Visibility(
                    visible: controller.emailError.value.isNotEmpty,
                    child: Column(
                      children: [
                        const SizedBox(height: 3),
                        Text(
                          controller.emailError.value,
                          style: TextStyle(
                            fontSize: 11,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.password,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedBuilder(
                  animation: controller.passwordShakeAnimation,
                  builder: (context, child) {
                    final double shakeOffset =
                        sin(controller.passwordShakeAnimation.value * pi * 2) *
                            5;
                    return Transform.translate(
                      offset: Offset(shakeOffset, 0),
                      child: SizedBox(
                        height: 40,
                        child: Obx(
                          () => TextField(
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocus,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              controller.passwordError.value = '';
                            },
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              isDense: true,
                              hintText: 'e. g. Yourpassword@123',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: controller.passwordError.isNotEmpty
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.surfaceTint,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: controller.passwordError.isNotEmpty
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: controller.passwordError.isNotEmpty
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.tertiary,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Obx(
                  () => Visibility(
                    visible: controller.passwordError.value.isNotEmpty,
                    child: Column(
                      children: [
                        const SizedBox(height: 3),
                        Text(
                          controller.passwordError.value,
                          style: TextStyle(
                            fontSize: 11,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.confirm_password,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedBuilder(
                  animation: controller.confirmPasswordShakeAnimation,
                  builder: (context, child) {
                    final double shakeOffset = sin(
                            controller.confirmPasswordShakeAnimation.value *
                                pi *
                                2) *
                        5;
                    return Transform.translate(
                      offset: Offset(shakeOffset, shakeOffset),
                      child: SizedBox(
                        height: 40,
                        child: Obx(
                          () => TextField(
                            controller: controller.conPasswordController,
                            focusNode: controller.confirmPasswordFocus,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            onChanged: (value) {
                              controller.confirmPasswordError.value = '';
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              isDense: true,
                              hintText: 'e. g. Yourpassword@123',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color:
                                    controller.confirmPasswordError.isNotEmpty
                                        ? Get.theme.colorScheme.primary
                                        : Get.theme.colorScheme.surfaceTint,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      controller.confirmPasswordError.isNotEmpty
                                          ? Get.theme.colorScheme.primary
                                          : Get.theme.colorScheme.tertiary,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      controller.confirmPasswordError.isNotEmpty
                                          ? Get.theme.colorScheme.primary
                                          : Get.theme.colorScheme.tertiary,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Obx(
                  () => Visibility(
                    visible: controller.confirmPasswordError.value.isNotEmpty,
                    child: Column(
                      children: [
                        const SizedBox(height: 3),
                        Text(
                          controller.confirmPasswordError.value,
                          style: TextStyle(
                            fontSize: 11,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    controller.validateInput();
                    if (controller.emailError.isEmpty &&
                        controller.passwordError.isEmpty &&
                        controller.confirmPasswordError.isEmpty) {
                      Get.toNamed(Routes.selectProfile);
                    }
                    // if (controller.formKey.currentState!.validate()) {
                    //   Get.snackbar('Sign up', 'Sign up successful');
                    // }
                  },
                  child: Container(
                    width: double.infinity,
                    // height: 37,
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    color: Get.theme.colorScheme.primary,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
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
    );
  }
}
