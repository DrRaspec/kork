import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../controllers/sign_up_controller.dart';
part '../bindings/sign_up_binding.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

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
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.sign_up,
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.create_account,
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
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
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
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
                      TextFormField(
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          hintText:
                              AppLocalizations.of(context)!.password_quide,
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
                      TextFormField(
                        controller: controller.conPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm Password can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          hintText: AppLocalizations.of(context)!
                              .confirm_new_password,
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
                      GestureDetector(
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            Get.snackbar('Sign up', 'Sign up successful');
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          // height: 37,
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          color: Get.theme.colorScheme.primary,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.create_account,
                              style: TextStyle(
                                fontSize: 16,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        AppLocalizations.of(context)!.sign_up_with,
                        style: TextStyle(
                          fontSize: 16,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 37,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/image/svg/facebook_icon.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 16),
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
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 37,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/image/svg/google_icon.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                AppLocalizations.of(context)!
                                    .sign_in_with_gmail,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_have_acc,
                            style: TextStyle(
                              fontSize: 16,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => Get.offNamedUntil(
                              Routes.login,
                              (route) => false,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xffC9131E),
                              ),
                            ),
                          ),
                        ],
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
