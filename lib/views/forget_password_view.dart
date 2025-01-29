import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../controllers/forget_password_controller.dart';
part '../bindings/forget_password_binding.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

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
                      AppLocalizations.of(context)!.forget_your_password,
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
                      AppLocalizations.of(context)!.forget_your_password_guide,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.theme.colorScheme.surfaceTint,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email can\'t be empty';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Incorrect email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          hintText: 'example@gmail.com',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.surfaceTint,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Get.theme.colorScheme.tertiary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.back_to_login,
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
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xffC9131E),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            Get.toNamed(Routes.verifyOtp);
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
