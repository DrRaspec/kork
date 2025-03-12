import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buttonBack() {
  return GestureDetector(
    onTap: Get.back,
    child: Icon(
      Icons.arrow_back_ios_new_outlined,
      size: 20,
      color: Get.theme.colorScheme.tertiary,
    ),
  );
}

Widget appbarTitle(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Get.theme.colorScheme.tertiary,
      fontSize: 20,
    ),
  );
}
