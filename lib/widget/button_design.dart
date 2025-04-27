import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/utils/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buttonDesign({
  required String text,
  String? image,
  Status status = Status.success,
  double width = double.infinity,
  double height = 38,
  double radius = 5,
  bool isKhmer = false,
  double fontSize = 16,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Get.theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image != null
            ? SizedBox(
                width: 24,
                height: 18,
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox.shrink(),
        image != null ? const SizedBox(width: 8) : const SizedBox.shrink(),
        status == Status.success
            ? Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isKhmer ? FontWeight.w900 : FontWeight.normal,
                  color: const Color(0xffEAE9FC),
                ),
              )
            : status != Status.error
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Color(0xffEAE9FC),
                    ),
                  )
                : Text(
                    AppLocalizations.of(Get.context!)!.retry,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: const Color(0xffEAE9FC),
                    ),
                  ),
      ],
    ),
  );
}
