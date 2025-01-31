import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../controllers/change_password_controller.dart';
part '../bindings/change_password_binding.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

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
                      AppLocalizations.of(context)!.change_password,
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
                      AppLocalizations.of(context)!.change_password_guide,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.theme.colorScheme.tertiary,
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
                          AppLocalizations.of(context)!.new_password,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.newPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'New password can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          hintText: AppLocalizations.of(context)!.new_password,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.confirm_new_password,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.conNewPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm New password can\'t be empty';
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
                            color: Get.theme.colorScheme.tertiary,
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
                          // if (controller.formKey.currentState!.validate()) {
                          //   Get.toNamed(Routes.verifyOtp);
                          // }
                          Get.toNamed(Routes.login);
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
