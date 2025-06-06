import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide FormData;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/helper/send_otp.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/update_password/forget_password/forget_password_view.dart';
import 'package:kork/utils/status.dart';
import 'package:kork/widget/button_design.dart';
import 'package:kork/widget/otp_textfield.dart';
import 'package:kork/widget/underline_text.dart';

part 'verify_otp_controller.dart';
part 'verify_otp_binding.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 10) {
          Get.back();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                        AppLocalizations.of(context)!.verify,
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
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 177,
                      child: Text(
                        AppLocalizations.of(context)!.verify_guide,
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.surfaceTint,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) {
                      if (event is KeyDownEvent &&
                          event.logicalKey == LogicalKeyboardKey.backspace) {
                        for (int i = controller.otpControllers.length - 1;
                            i >= 0;
                            i--) {
                          if (controller.otpControllers[i].text.isNotEmpty) {
                            controller.otpControllers[i].clear();
                            controller.otpFocusNodes[i].requestFocus();
                            break;
                          } else if (i > 0) {
                            controller.otpFocusNodes[i - 1].requestFocus();
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return otpTextField(
                          controller.otpControllers[index],
                          controller.otpFocusNodes[index],
                          context,
                          next: index < 3,
                          previous: index > 0,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24),
                  controller.isNew
                      ? GestureDetector(
                          onTap: () => Get.offNamed(Routes.signup),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomPaint(
                              painter: UnderlineText(),
                              child: Text(
                                AppLocalizations.of(context)!.change_email,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.not_receive_code,
                              style: TextStyle(
                                fontSize: 14,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: controller.resendOTP,
                              child: Text(
                                AppLocalizations.of(context)!.resend,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffC9131E),
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 24),
                  Obx(
                    () => GestureDetector(
                      onTap: controller.status.value == Status.loading
                          ? null
                          : controller.onTapVerifyOTP,
                      child: buttonDesign(
                        text: controller.isNew
                            ? AppLocalizations.of(context)!.confirm
                            : AppLocalizations.of(context)!.next,
                        status: controller.status.value,
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: controller.onTapVerifyOTP,
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: Get.theme.colorScheme.primary,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         controller.isNew
                  //             ? AppLocalizations.of(context)!.confirm
                  //             : AppLocalizations.of(context)!.next,
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           color: Color(0xffEAE9FC),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
