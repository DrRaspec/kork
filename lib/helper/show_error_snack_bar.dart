import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnackBar(String message) {
  Get.snackbar(
    'Error',
    message,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.TOP,
  );
}