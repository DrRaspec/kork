import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget settingList({
  required String path,
  required String text,
  int? notificationNum,
}) {
  return Row(
    children: [
      SvgPicture.asset(
        path,
        width: 16,
        height: 16,
        colorFilter: ColorFilter.mode(
          Get.theme.colorScheme.tertiary,
          BlendMode.srcIn,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
      ),
      notificationNum != null
          ? Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.colorScheme.primary,
              ),
              child: Text(
                notificationNum > 99 ? '99+' : '$notificationNum',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: notificationNum > 99 ? 9 : 12,
                  color: const Color(0xffEAE9FC),
                ),
              ),
            )
          : const SizedBox.shrink(),
      const SizedBox(width: 12),
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
  );
}
