import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kork/routes/routes.dart';

part '../controllers/select_profile_controller.dart';
part '../bindings/select_profile_binding.dart';

class SelectProfileView extends GetView<SelectProfileController> {
  const SelectProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      onTap: () => Get.toNamed(Routes.selectLocation),
                      child: Text(
                        AppLocalizations.of(context)!.skip,
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.choose_profile,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ClipOval(
                  child: Image.asset(
                    'assets/image/defualt_profile.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.theme.colorScheme.tertiary,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.choose_image,
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
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
