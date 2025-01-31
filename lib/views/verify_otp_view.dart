import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../controllers/verify_otp_controller.dart';
part '../bindings/verify_otp_binding.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.onInverseSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/image/Artboard 1 2.png',
                  width: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: Text(
                      AppLocalizations.of(context)!.verify,
                      style: TextStyle(
                        fontSize: 16,
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
                        color: Get.theme.colorScheme.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 34,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: controller.textFieldOne,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    Get.focusScope!.nextFocus();
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: controller.textFieldTwo,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    Get.focusScope!.nextFocus();
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: controller.textFieldThree,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    Get.focusScope!.nextFocus();
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: controller.textFieldFour,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
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
                          if (controller.formKey.currentState!.validate()) {
                            Get.toNamed(Routes.changePassword);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          // height: 37,
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          color: Get.theme.colorScheme.primary,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.next,
                              style: TextStyle(
                                fontSize: 16,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
