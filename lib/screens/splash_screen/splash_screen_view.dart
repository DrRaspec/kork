import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
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
            Obx(
              () => Image.asset(
                // Get.isDarkMode
                //     ? 'assets/image/logo.png'
                //     : 'assets/image/light-logo.png',
                controller.image.value,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            LottieBuilder.asset(
              'assets/animation/animation_splash_screen.json',
              frameRate: FrameRate.max,
              fit: BoxFit.cover,
              width: 64,
              height: 64,
              repeat: true,
            ),
          ],
        ),
      ),
    );
  }
}
