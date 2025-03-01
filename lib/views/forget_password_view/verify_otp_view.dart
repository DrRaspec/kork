import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/views/forget_password_view/forget_password_view.dart';
import 'package:kork/widget/otp_textfield.dart';
import 'package:kork/widget/underline_text.dart';

part '../../controllers/forget_password/verify_otp_controller.dart';
part '../../bindings/forget_password/verify_otp_binding.dart';

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
                        final currentFocus = FocusManager.instance.primaryFocus;

                        if (controller.textFieldFour.text.isEmpty &&
                            currentFocus == controller.focusNodeFour) {
                          FocusScope.of(context).previousFocus();
                        } else if (controller.textFieldThree.text.isEmpty &&
                            currentFocus == controller.focusNodeThree) {
                          FocusScope.of(context).previousFocus();
                        } else if (controller.textFieldTwo.text.isEmpty &&
                            currentFocus == controller.focusNodeTwo) {
                          FocusScope.of(context).previousFocus();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        otpTextField(
                          controller.textFieldOne,
                          controller.focusNodeOne,
                          context,
                          next: true,
                        ),
                        otpTextField(
                          controller.textFieldTwo,
                          controller.focusNodeTwo,
                          context,
                          next: true,
                          previous: true,
                        ),
                        otpTextField(
                          controller.textFieldThree,
                          controller.focusNodeThree,
                          context,
                          next: true,
                          previous: true,
                        ),
                        otpTextField(
                          controller.textFieldFour,
                          controller.focusNodeFour,
                          context,
                          previous: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  controller.isNew
                      ? GestureDetector(
                          onTap: () => Get.toNamed(Routes.signup),
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
                              onTap: () => Get.offNamedUntil(
                                Routes.login,
                                (route) => false,
                              ),
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
                  GestureDetector(
                    onTap: () {
                      controller.validateInput();
                      if (controller.isEmpty.value) {
                        if (controller.isNew) {
                          Get.toNamed(Routes.selectProfile);
                        }
                        Get.toNamed(Routes.changePassword);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          controller.isNew
                              ? AppLocalizations.of(context)!.confirm
                              : AppLocalizations.of(context)!.next,
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
