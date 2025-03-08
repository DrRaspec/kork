import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget eventRecentSearch() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(
        'assets/image/svg/clock.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          Get.theme.colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
      const SizedBox(width: 16),
      Text(
        'Listening party with fan',
        style: TextStyle(
          fontSize: 12,
          color: Get.theme.colorScheme.tertiary,
        ),
      ),
      const Spacer(),
      SvgPicture.asset(
        'assets/image/svg/dangerous.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          Get.theme.colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
    ],
  );
}
