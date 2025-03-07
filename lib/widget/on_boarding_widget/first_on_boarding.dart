import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

Widget firstOnBoarding(BuildContext context) {
  return Column(
    children: [
      Image.asset(
        'assets/image/onboarding_image.png',
        width: 344,
        height: 344,
        fit: BoxFit.cover,
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          AppLocalizations.of(context)!.book_your_idol_event,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          AppLocalizations.of(context)!.book_meet_your_idol,
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
