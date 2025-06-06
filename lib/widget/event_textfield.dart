import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget eventTextField({
  required TextEditingController textController,
  required FocusNode textFocus,
  required String errorMessage,
  required String hintText,
  String? svgIcon,
  bool isEnable = true,
}) {
  var context = Get.context;
  if (context == null) return const SizedBox.shrink();
  return SizedBox(
    height: 40,
    child: TextField(
      controller: textController,
      focusNode: textFocus,
      enabled: isEnable,
      style: TextStyle(
        fontSize: 10,
        color: Get.theme.colorScheme.tertiary,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 10,
          color: Get.theme.colorScheme.surfaceTint,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Get.theme.colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Get.theme.colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        suffixIcon: svgIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: SvgPicture.asset(
                  svgIcon,
                  colorFilter: ColorFilter.mode(
                    Get.theme.colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    ),
  );
}
