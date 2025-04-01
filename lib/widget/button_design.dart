import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/utils/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buttonDesign(
    {required String text, String? image, Status status = Status.success}) {
  return Container(
    width: double.infinity,
    height: 38,
    decoration: BoxDecoration(
      color: Get.theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(5),
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
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xffEAE9FC),
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
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xffEAE9FC),
                    ),
                  ),
      ],
    ),
  );
}
