import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/main_screens/event/event_view.dart';
import 'package:kork/screens/main_screens/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/main_screens/profile/profile_view.dart';
import 'package:kork/screens/main_screens/ticket/ticket_view.dart';
// import 'package:kork/widget/buttom_navigationbar.dart';

part 'main_binding.dart';
part 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.textTheme.bodyLarge!.fontFamily);
    return Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,
            children: controller.screens,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/image/svg/camera_indoor.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    controller.currentIndex.value == 0
                        ? Get.theme.colorScheme.primary
                        : Get.theme.colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/image/svg/counter_7.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    controller.currentIndex.value == 1
                        ? Get.theme.colorScheme.primary
                        : Get.theme.colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/image/svg/local_activity.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    controller.currentIndex.value == 2
                        ? Get.theme.colorScheme.primary
                        : Get.theme.colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppLocalizations.of(context)!.ticket,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/image/svg/person.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    controller.currentIndex.value == 3
                        ? Get.theme.colorScheme.primary
                        : Get.theme.colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
            selectedLabelStyle: TextStyle(
              fontSize: 10,
              color: Get.theme.colorScheme.primary,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 10,
              color: Get.theme.colorScheme.tertiary,
            ),
            currentIndex: controller.currentIndex.value,
            backgroundColor: Get.theme.bottomNavigationBarTheme.backgroundColor,
            onTap: (index) => controller.changeTabIndex(index),
            selectedItemColor: Get.theme.colorScheme.primary,
            unselectedItemColor: Get.theme.colorScheme.tertiary,
            type: BottomNavigationBarType.fixed,
          ),
        )
        // Stack(
        //   children: [
        //     Positioned.fill(
        //       child: Obx(
        //         () => IndexedStack(
        //           index: controller.currentIndex.value,
        //           children: controller.screens,
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       left: 0,
        //       bottom: 0,
        //       child: SizedBox(
        //           width: Get.width,
        //           height: 80,
        //           child: Stack(
        //             children: [
        //               Positioned(
        //                 bottom: 0,
        //                 child: Container(
        //                   width: Get.width,
        //                   height: 65,
        //                   color:
        //                       Get.theme.bottomNavigationBarTheme.backgroundColor,
        //                   child: Obx(
        //                     () => buttomNavigationbar(),
        //                   ),
        //                 ),
        //               ),
        //               Center(
        //                 heightFactor: 0.8,
        //                 child: GestureDetector(
        //                   onTap: () {},
        //                   child: Container(
        //                     width: 56,
        //                     height: 56,
        //                     clipBehavior: Clip.hardEdge,
        //                     alignment: Alignment.center,
        //                     decoration: BoxDecoration(
        //                       shape: BoxShape.circle,
        //                       gradient: LinearGradient(
        //                         colors: [
        //                           Get.theme.colorScheme.secondary,
        //                           Get.theme.colorScheme.primary,
        //                         ],
        //                         begin: Alignment.topCenter,
        //                         end: Alignment.bottomCenter,
        //                         // stops: const [0.1, .50],
        //                       ),
        //                       boxShadow: [
        //                         BoxShadow(
        //                           color: Colors.black.withOpacity(0.3),
        //                           blurRadius: 10,
        //                           spreadRadius: 2,
        //                           offset: const Offset(0, 4),
        //                         ),
        //                       ],
        //                     ),
        //                     child: SvgPicture.asset(
        //                       'assets/image/svg/add_circle.svg',
        //                       width: 24,
        //                       colorFilter: const ColorFilter.mode(
        //                         Color(0xffEAE9FC),
        //                         BlendMode.srcIn,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )),
        //     ),
        //   ],
        // ),
        );
  }
}
