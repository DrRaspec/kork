import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide FormData;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/utils/status.dart';

part 'change_password_controller.dart';
part 'change_password_binding.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

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
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      child: Text(
                        AppLocalizations.of(context)!.change_password,
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
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      AppLocalizations.of(context)!.change_password_guide,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.theme.colorScheme.surfaceTint,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.new_password,
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: controller.passwordShakeController,
                    builder: (context, child) {
                      final shakeOffset = sin(
                              controller.passwordShakeAnimation.value *
                                  pi *
                                  2) *
                          5;
                      return Transform.translate(
                        offset: Offset(shakeOffset, 0),
                        child: SizedBox(
                          height: 40,
                          child: Obx(
                            () => TextField(
                              controller: controller.newPassword,
                              focusNode: controller.passwordFocus,
                              obscureText: controller.passwordObsecure.value,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .enter_new_passowrd,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.passwordObsecure.value =
                                        !controller.passwordObsecure.value;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 11,
                                    ),
                                    child: SvgPicture.asset(
                                      controller.passwordObsecure.value
                                          ? 'assets/image/svg/eye.svg'
                                          : 'assets/image/svg/eye-slash.svg',
                                      fit: BoxFit.scaleDown,
                                      colorFilter: ColorFilter.mode(
                                        Get.theme.colorScheme.tertiary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: controller.passwordError.isNotEmpty
                                        ? Get.theme.colorScheme.primary
                                        : Get.theme.colorScheme.tertiary,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: controller.passwordError.isNotEmpty
                                        ? Get.theme.colorScheme.primary
                                        : Get.theme.colorScheme.tertiary,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: controller.passwordError.isNotEmpty
                                        ? Get.theme.colorScheme.primary
                                        : Get.theme.colorScheme.tertiary,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () => controller.passwordError.value.isNotEmpty
                        ? Text(
                            controller.passwordError.value,
                            style: TextStyle(
                              fontSize: 11,
                              color: Get.theme.colorScheme.primary,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: controller.conPasswordShakeController,
                    builder: (context, child) {
                      final shakeOffset = sin(
                              controller.conPasswordShakeAnimation.value *
                                  pi *
                                  2) *
                          5;
                      return Transform.translate(
                        offset: Offset(shakeOffset, 0),
                        child: SizedBox(
                          height: 40,
                          child: Obx(
                            () => TextField(
                              controller: controller.conNewPassword,
                              focusNode: controller.conPasswordFocus,
                              obscureText: controller.conPasswordObsecure.value,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .confirm_new_passowrd,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.conPasswordObsecure.value =
                                        !controller.conPasswordObsecure.value;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 11,
                                    ),
                                    child: SvgPicture.asset(
                                      controller.conPasswordObsecure.value
                                          ? 'assets/image/svg/eye.svg'
                                          : 'assets/image/svg/eye-slash.svg',
                                      fit: BoxFit.scaleDown,
                                      colorFilter: ColorFilter.mode(
                                        Get.theme.colorScheme.tertiary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        controller.conPasswordError.isNotEmpty
                                            ? Get.theme.colorScheme.primary
                                            : Get.theme.colorScheme.tertiary,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        controller.conPasswordError.isNotEmpty
                                            ? Get.theme.colorScheme.primary
                                            : Get.theme.colorScheme.tertiary,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        controller.conPasswordError.isNotEmpty
                                            ? Get.theme.colorScheme.primary
                                            : Get.theme.colorScheme.tertiary,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () => controller.conPasswordError.value.isNotEmpty
                        ? Text(
                            controller.conPasswordError.value,
                            style: TextStyle(
                              fontSize: 11,
                              color: Get.theme.colorScheme.primary,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 24),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (controller.status.value == Status.loading) return;
                        controller.validateInput();
                        if (controller.conPasswordError.isEmpty &&
                            controller.passwordError.isEmpty) {
                          controller.updatePassword();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: controller.status.value == Status.loading
                              ? Get.theme.colorScheme.primary
                                  .withAlpha((0.8 * 255).round())
                              : Get.theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: controller.status.value == Status.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Color(0xffEAE9FC),
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(context)!.done,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffEAE9FC),
                                  ),
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
