import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_controller.dart';
part 'login_binding.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            // vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 17),
              Image.asset(
                Get.isDarkMode
                    ? 'assets/image/logo.png'
                    : 'assets/image/light-logo.png',
                width: 70,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.signin,
                  style: TextStyle(
                    fontSize: 20,
                    color: Get.theme.colorScheme.tertiary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25),
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
              SizedBox(
                height: 40,
                child: AnimatedBuilder(
                  animation: controller.emailShakeAnimation,
                  builder: (context, child) {
                    final double shakeOffset = sin(
                          controller.emailShakeAnimation.value * 2 * pi,
                        ) *
                        5;
                    return Transform.translate(
                      offset: Offset(shakeOffset, 0),
                      child: Obx(
                        () => TextField(
                          controller: controller.emailController,
                          focusNode: controller.emailFocusNode,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12.5,
                            ),
                            // constraints: const BoxConstraints(minHeight: 40),
                            hintText: 'e. g. youremail@mail.com',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.surfaceTint,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: controller.emailError.isNotEmpty
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: controller.emailError.isNotEmpty
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            suffixIcon: Visibility(
                              visible: controller.emailError.isNotEmpty,
                              child: Icon(
                                Icons.error,
                                size: 20,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(
                () => controller.emailError.isNotEmpty
                    ? Column(
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
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
              SizedBox(
                // constraints: const BoxConstraints(
                //   minHeight: 40,
                // ),
                height: 40,
                child: AnimatedBuilder(
                  animation: controller.passwordShakeAnimation,
                  builder: (context, child) {
                    final double shakeOffset = sin(
                          controller.passwordShakeAnimation.value * 2 * pi,
                        ) *
                        5;
                    return Transform.translate(
                      offset: Offset(
                        shakeOffset,
                        0,
                      ),
                      child: Obx(
                        () => TextField(
                          controller: controller.passwordController,
                          focusNode: controller.passwordFocusNode,
                          obscureText: controller.passwordObsecure.value,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12.5,
                            ),
                            isDense: true,
                            // constraints: const BoxConstraints(minHeight: 40),
                            hintText: 'e. g. yourpassword@123',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.surfaceTint,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: controller.passwordError.isNotEmpty
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.tertiary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: controller.passwordError.isNotEmpty
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 11,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  controller.passwordObsecure.value =
                                      !controller.passwordObsecure.value;
                                },
                                child: SizedBox(
                                  child: SvgPicture.asset(
                                    !controller.passwordObsecure.value
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
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(
                () => controller.passwordError.isNotEmpty
                    ? Column(
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
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.forgetPassword),
                  child: Text(
                    AppLocalizations.of(context)!.forget_password,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => GestureDetector(
                    onTap: controller.isLoading.value
                        ? null
                        : controller.loginOntap,
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: controller.isLoading.value
                            ? Get.theme.colorScheme.primary.withOpacity(0.6)
                            : Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xffEAE9FC),
                                ),
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.signin,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xffEAE9FC),
                              ),
                            ),
                    ),
                  )),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sign_up_with,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/image/svg/google_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!.sign_in_with_gmail,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(width: 22.5),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/image/svg/facebook_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!.sign_in_with_fb,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dont_have_acc,
                    style: TextStyle(
                      fontSize: 14,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.firstSignup,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xffC9131E),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Obx(
//                       () => shakeTextfield(
//                         shakeAnimation: controller.cardNumberShakeAnimation,
//                         textfieldCtrl: controller.cardNumberController,
//                         shakeController: controller.cardNumberShakeController,
//                         focusnode: controller.cardNumberFocus,
//                         hintext: AppLocalizations.of(context)!.card_number,
//                         errorMessage: controller.cardNumberError.value,
//                       ),
//                     ),
