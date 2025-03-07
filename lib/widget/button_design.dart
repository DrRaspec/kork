import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buttonDesign(String text) {
  return Container(
    width: double.infinity,
    height: 38,
    decoration: BoxDecoration(
      color: Get.theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xffEAE9FC),
        ),
      ),
    ),
  );
}
