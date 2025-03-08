import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/screens/main_screens/event/event_view.dart';
import 'package:kork/screens/main_screens/home/home_view.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/main_screens/profile/profile_view.dart';
import 'package:kork/screens/main_screens/ticket/ticket_view.dart';
import 'package:kork/screens/widget/buttom_navigationbar.dart';

part 'main_binding.dart';
part 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.textTheme.bodyLarge!.fontFamily);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => IndexedStack(
                index: controller.currentIndex.value,
                children: controller.screen,
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
                width: Get.width,
                height: 80,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: Get.width,
                        height: 65,
                        color:
                            Get.theme.bottomNavigationBarTheme.backgroundColor,
                        child: Obx(
                          () => buttomNavigationbar(),
                        ),
                      ),
                    ),
                    // CustomPaint(
                    //   size: Size(Get.width, 80),
                    //   painter: MyPainter(),
                    // ),
                    Center(
                      heightFactor: 0.8,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 56,
                          height: 56,
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Get.theme.colorScheme.secondary,
                                Get.theme.colorScheme.primary,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              // stops: const [0.1, .50],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            'assets/image/svg/add_circle.svg',
                            width: 24,
                            colorFilter: const ColorFilter.mode(
                              Color(0xffEAE9FC),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
