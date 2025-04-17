import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/button_design.dart';
import 'package:kork/widget/up_coming_widget.dart';

part 'edit_profile_binding.dart';

part 'edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.edit_profile),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () => _showDialog(),
                          child: Container(
                            height: 116,
                            width: 116,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Get.theme.colorScheme.tertiary,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: Obx(
                                () => controller.selectedImage.value == null
                                    ? controller.userData.value != null
                                        ? Image.network(
                                            controller
                                                .userData.value!.profileUrl!,
                                            width: 116,
                                            height: 116,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return buildPlaceholder();
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Center(
                                              child: Icon(
                                                Icons.error,
                                                size: 30,
                                              ),
                                            ),
                                          )
                                        : const Icon(
                                            Icons.error,
                                            size: 30,
                                          )
                                    : Image.file(
                                        controller.selectedImage.value!,
                                        width: 116,
                                        height: 116,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Obx(
                          () => Text(
                            controller.fullName.value,
                            style: TextStyle(
                              fontSize: 20,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: controller.firstNameController,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Get.theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              hintText:
                                  AppLocalizations.of(context)!.first_name,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.surfaceTint,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: controller.lastNameController,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Get.theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              hintText: AppLocalizations.of(context)!.last_name,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.surfaceTint,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.password_security,
                            style: TextStyle(
                              fontSize: 14,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () =>
                              Get.toNamed(Routes.profileChangePassword),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.change_password,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/image/svg/arrow-right.svg',
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  Get.theme.colorScheme.tertiary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 8),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       AppLocalizations.of(context)!.phone_number,
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Get.theme.colorScheme.tertiary,
                        //       ),
                        //     ),
                        //     SvgPicture.asset(
                        //       'assets/image/svg/arrow-right.svg',
                        //       width: 16,
                        //       height: 16,
                        //       colorFilter: ColorFilter.mode(
                        //         Get.theme.colorScheme.tertiary,
                        //         BlendMode.srcIn,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: GestureDetector(
                  onTap: controller.saveChangeName,
                  child: buttonDesign(
                    text: AppLocalizations.of(context)!.save,
                  ),
                ),
              ),
            ],
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
