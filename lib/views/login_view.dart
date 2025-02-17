import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../controllers/login_controller.dart';
part '../bindings/login_binding.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.email_username,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        // height: 40,
                        constraints: const BoxConstraints(
                          minHeight: 40,
                        ),
                        child: TextFormField(
                          controller: controller.emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email can\'t be empty';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12.5,
                            ),
                            constraints: const BoxConstraints(minHeight: 40),
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
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 40,
                        ),
                        child: TextFormField(
                          controller: controller.passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12.5,
                            ),
                            isDense: true,
                            constraints: const BoxConstraints(minHeight: 40),
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
                          ),
                        ),
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
                      GestureDetector(
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            Get.snackbar('Sign up', 'Sign up successful');
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signin,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xffEAE9FC),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
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
                                AppLocalizations.of(context)!
                                    .sign_in_with_gmail,
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
                          const SizedBox(width: 8),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
