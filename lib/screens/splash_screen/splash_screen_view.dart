import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_screen_binding.dart';
part 'splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Get.isDarkMode
                  ? 'assets/image/logo.png'
                  : 'assets/image/light-logo.png',
              width: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            LottieBuilder.asset(
              'assets/animation/splash_screen.json',
            ),
          ],
        ),
      ),
    );
  }
}
