import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/sign_up_view/first_signup/first_signup_view.dart';
import 'package:kork/screens/sign_up_view/map/map_view.dart';
import 'package:kork/screens/sign_up_view/select_profile/select_profile_view.dart';
import 'package:kork/screens/sign_up_view/signup/sign_up_view.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'select_location_controller.dart';
part 'select_location_binding.dart';

class SelectLocationView extends GetView<SelectLocationController> {
  const SelectLocationView({super.key});

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
                      onTap: Get.back,
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
                  AppLocalizations.of(context)!.location,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.select_current_location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/image/map_image.png',
                  width: 315,
                  height: 252,
                ),
                LayoutBuilder(builder: (context, constraits) {
                  return SizedBox(
                    width: constraits.maxWidth * 0.7,
                    child: Text(
                      AppLocalizations.of(context)!.please_choose_location,
                      style: TextStyle(
                        color: Get.theme.colorScheme.surfaceTint,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => Get.toNamed(
                    Routes.mapView,
                    arguments: Routes.login,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.select_location_on_map,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.or,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: controller.getCurrentLocation,
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Get.theme.colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        controller.isLoading.value
                            ? controller.loadingText.value
                            : AppLocalizations.of(context)!
                                .get_current_location,
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
        ),
      ),
    );
  }
}
