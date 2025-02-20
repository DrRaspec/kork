import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShakeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController shakeAnimationController;
  late Animation<double> shakeAnimation;

  ShakeController._();

  @override
  void onInit() {
    super.onInit();
    shakeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(shakeAnimationController);
  }

  void triggerShake() {
    shakeAnimationController.forward(from: 0);
  }

  @override
  void onClose() {
    shakeAnimationController.dispose();
    super.onClose();
  }
}
