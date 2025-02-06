import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/views/filter_view.dart';

Widget filterDateWidget(String text) {
  var controller = Get.find<FilterController>();
  final isMatch = controller.selectDate.value == text;
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }

  return GestureDetector(
    onTap: () => controller.updateSelectDate(text),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 23,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color:
            isMatch ? Get.theme.colorScheme.primary : const Color(0xff252525),
        border: Border.all(
          color: isMatch
              ? Get.theme.colorScheme.primary
              : Get.theme.colorScheme.tertiary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Get.theme.colorScheme.tertiary,
          fontSize: 15,
        ),
      ),
    ),
  );
}
