import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/views/event_detail.dart';

Widget ticketType(String text) {
  var selectedType = Get.find<EventDetailController>().selectedType;
  return Expanded(
    child: Material(
      child: Obx(
        () => InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () => selectedType.value = text,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
              border: Border.all(
                width: 2,
                color: selectedType.value == text
                    ? Get.theme.colorScheme.tertiary
                    : Get.theme.colorScheme.primary,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Get.theme.colorScheme.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
