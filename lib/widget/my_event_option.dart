import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget myEventOption({
  required String text,
  required String icon,
  int? notification,
  Widget? customWidget,
}) {
  return Container(
    height: 40,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Get.theme.colorScheme.secondary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      spacing: 16,
      children: [
        SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter:
              ColorFilter.mode(Get.theme.colorScheme.tertiary, BlendMode.srcIn),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Get.theme.colorScheme.tertiary,
            ),
          ),
        ),
        notification == null
            ? const SizedBox.shrink()
            : Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    notification > 99 ? '99+' : notification.toString(),
                    style: TextStyle(
                      fontSize: notification > 99 ? 10 : 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
        customWidget ??
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
              color: Get.theme.colorScheme.tertiary,
            ),
      ],
    ),
  );
}
