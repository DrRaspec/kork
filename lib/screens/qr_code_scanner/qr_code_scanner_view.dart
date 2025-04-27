import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/main.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/widget/button_design.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'qr_code_scanner_binding.dart';
part 'qr_code_scanner_controller.dart';

class QrCodeScannerView extends GetView<QrCodeScannerViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.scannerController,
            onDetect: controller.onDetectQrCode,
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: controller.languageCode.value == 'en'
                            ? AppLocalizations.of(context)!.kork
                            : AppLocalizations.of(context)!.app,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: controller.languageCode.value == 'en'
                              ? Get.theme.colorScheme.primary
                              : Get.theme.colorScheme.tertiary,
                        ),
                        children: [
                          const TextSpan(text: " "),
                          TextSpan(
                            text: controller.languageCode.value == 'en'
                                ? AppLocalizations.of(context)!.app
                                : AppLocalizations.of(context)!.kork,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: controller.languageCode.value == 'en'
                                  ? Get.theme.colorScheme.tertiary
                                  : Get.theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 62),
                  SvgPicture.asset(
                    'assets/image/svg/scanner_frame.svg',
                    width: 250,
                    height: 250,
                    colorFilter: ColorFilter.mode(
                      Get.theme.colorScheme.tertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: controller.toggleFlash,
                    child: Container(
                      width: Get.width * 0.4,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            Get.theme.bottomNavigationBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => SvgPicture.asset(
                              'assets/image/svg/flash.svg',
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                controller.isFlashOn.value
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.tertiary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            AppLocalizations.of(context)!.flash,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 32,
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Get.isDarkMode
                        ? 'assets/image/logo.png'
                        : 'assets/image/light-logo.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  GestureDetector(
                    onTap: Get.back,
                    child: SvgPicture.asset(
                      'assets/image/svg/tag-cross.svg',
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Get.theme.colorScheme.tertiary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
