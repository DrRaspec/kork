import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';
// import 'package:flutter_svg/flutter_svg.dart';

part '../controllers/login_controller.dart';
part '../bindings/login_binding.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
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
                    AppLocalizations.of(context)!.login,
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
                                color: Get.theme.colorScheme.tertiary),
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
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.isRemember.value =
                                    !controller.isRemember.value;
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Get.theme.colorScheme.tertiary,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: controller.isRemember.value
                                    ? Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Get.theme.colorScheme.tertiary,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            AppLocalizations.of(context)!.remember_me,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.forgetPassword),
                            child: Text(
                              AppLocalizations.of(context)!.forget_password,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ],
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
                              AppLocalizations.of(context)!.login,
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
                          child: Center(
                            child: SizedBox(
                              width: 175,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/image/svg/facebook_icon.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .sign_in_with_fb,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                          child: Center(
                            child: SizedBox(
                              width: 175,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dont_have_acc,
                            style: TextStyle(
                              fontSize: 16,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.signup),
                            child: Text(
                              AppLocalizations.of(context)!.sign_up,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xffC9131E),
                              ),
                            ),
                          )
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
