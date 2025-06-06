import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/screens/search_event/search_event.dart';

Widget eventRecentSearch(String text) {
  final controller = Get.find<SearchEventController>();
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
        text,
        style: TextStyle(
          fontSize: 12,
          color: Get.theme.colorScheme.tertiary,
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: () => controller.removeRecentSearch(text),
        child: SvgPicture.asset(
          'assets/image/svg/dangerous.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Get.theme.colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
    ],
  );
}
