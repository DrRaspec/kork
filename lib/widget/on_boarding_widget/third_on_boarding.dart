import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

Widget thirdOnBoarding(BuildContext context) {
  return Column(
    children: [
      Image.asset(
        'assets/image/third_on_boarding.png',
        width: 344,
        height: 344,
        fit: BoxFit.cover,
      ),
      const SizedBox(height: 16),
      Text(
        AppLocalizations.of(context)!.faster_than_other,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.theme.colorScheme.tertiary,
        ),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          AppLocalizations.of(context)!.experience_booking_like_never,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
      ),
    ],
  );
}
