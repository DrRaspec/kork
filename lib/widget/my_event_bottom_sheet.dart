import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget myEventBottomSheet() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Get.theme.scaffoldBackgroundColor,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => Get.back(), // Close the BottomSheet
          child: const Text("Close"),
        ),
      ],
    ),
  );
}
