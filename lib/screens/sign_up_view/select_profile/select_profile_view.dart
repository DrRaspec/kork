import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kork/routes/routes.dart';
import 'package:path_provider/path_provider.dart';

part 'select_profile_controller.dart';
part 'select_profile_binding.dart';

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
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 32),
                ClipOval(
                  child: Obx(
                    () => controller.selectedImage.value == null
                        ? Image.asset(
                            'assets/image/profile.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(controller.selectedImage.value!.path),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: _showDialog,
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
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.selectLocation),
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

  Future<void> _showDialog() {
    return showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      backgroundColor: const Color(0xff333333),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 106,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 16,
            children: [
              Expanded(
                child: SizedBox(
                  width: 74,
                  height: 90,
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 3,
                        children: [
                          Image.asset(
                            Platform.isAndroid
                                ? 'assets/image/android_gallery.png'
                                : 'assets/image/ios_gallery.png',
                            width: 48,
                          ),
                          Text(
                            AppLocalizations.of(context)!.gallery,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xffEAE9FC),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 32,
                width: 1,
                margin: const EdgeInsets.only(bottom: 10),
                color: const Color(0x80EAE9FC),
              ),
              Expanded(
                child: SizedBox(
                  width: 74,
                  height: 90,
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 3,
                        children: [
                          Image.asset(
                            Platform.isAndroid
                                ? 'assets/image/android_camera.png'
                                : 'assets/image/ios_camera.png',
                            width: 48,
                          ),
                          Text(
                            AppLocalizations.of(context)!.gallery,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xffEAE9FC),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
