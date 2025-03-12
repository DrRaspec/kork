import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

Widget secondOnBoarding(BuildContext context) {
  return Column(
    children: [
      Image.asset(
        'assets/image/second_on_boarding.png',
        width: 344,
        height: 344,
        fit: BoxFit.cover,
      ),
      const SizedBox(height: 16),
      Text(
        AppLocalizations.of(context)!.easy_and_confident,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.theme.colorScheme.tertiary,
        ),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          AppLocalizations.of(context)!.book_confident,
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
