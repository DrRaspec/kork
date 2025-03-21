import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:kork/models/user_accounts.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/button_design.dart';

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
        onHorizontalDragUpdate: (details) {
          Get.back();
        },
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
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Get.theme.colorScheme.tertiary,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              controller.userData.value!.profileUrl,
                              width: 116,
                              height: 116,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          controller.fullName.value,
                          style: TextStyle(
                            fontSize: 20,
                            color: Get.theme.colorScheme.tertiary,
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
                        Row(
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
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.phone_number,
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
}
