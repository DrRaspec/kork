import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:kork/main.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/edit_profile/edit_profile_view.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/button_design.dart';
import 'package:kork/widget/shake_textfield.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            text: controller.fullName.value,
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
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.password_quide,
                    style: TextStyle(
                      fontSize: 10,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => shakeTextfield(
                      shakeAnimation: controller.currentPasswordShakeAnimation,
                      textfieldCtrl: controller.currentPasswordController,
                      shakeController:
                          controller.currentPasswordShakeController,
                      focusnode: controller.currentPasswordFocus,
                      hintext: AppLocalizations.of(context)!.current_password,
                      errorMessage: controller.currentPasswordError.value,
                      obsecure: controller.obsecureCurrentPassword,
                    ),
                  ),
                  Obx(
                    () => controller.currentPasswordError.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 3),
                              Text(
                                controller.currentPasswordError.value,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => shakeTextfield(
                      shakeAnimation: controller.newPasswordShakeAnimation,
                      textfieldCtrl: controller.newPasswordController,
                      shakeController: controller.newPasswordShakeController,
                      focusnode: controller.newPasswordFocus,
                      hintext: AppLocalizations.of(context)!.new_password,
                      errorMessage: controller.newPasswordError.value,
                      obsecure: controller.obsecureNewPassword,
                    ),
                  ),
                  Obx(
                    () => controller.newPasswordError.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 3),
                              Text(
                                controller.newPasswordError.value,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => shakeTextfield(
                      shakeAnimation: controller.confirmPasswordShakeAnimation,
                      textfieldCtrl: controller.conPasswordController,
                      shakeController:
                          controller.confirmPasswordShakeController,
                      focusnode: controller.confirmPasswordFocus,
                      hintext:
                          AppLocalizations.of(context)!.re_enter_your_password,
                      errorMessage: controller.confirmPasswordError.value,
                      obsecure: controller.obsecureConfirmPassword,
                    ),
                  ),
                  Obx(
                    () => controller.confirmPasswordError.isNotEmpty
                        ? Column(
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
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.forgetPassword),
                      child: Text(
                        AppLocalizations.of(context)!.forget_password,
                        style: TextStyle(
                          fontSize: 10,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: controller.onTap,
                child: buttonDesign(
                  text: AppLocalizations.of(context)!.save,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
