import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/screens/filter_screens/filter/filter_view.dart';

Widget filterDateWidget(String text) {
  var controller = Get.find<FilterController>();
  final isMatch = controller.selectDate.value == text;
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }

  return Expanded(
    child: GestureDetector(
      onTap: () {
        controller.pickedDate.value = null;
        controller.updateSelectDate(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          // horizontal: 23,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isMatch
              ? Get.theme.colorScheme.primary
              : Get.theme.colorScheme.filterBackground,
          border: Border.all(
            color: isMatch
                ? Get.theme.colorScheme.primary
                : Get.theme.colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isMatch
                  ? const Color(0xffEAE9FC)
                  : Get.theme.colorScheme.tertiary,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ),
  );
}
