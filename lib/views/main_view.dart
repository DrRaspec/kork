import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/views/event_view.dart';
import 'package:kork/views/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/views/profile_view.dart';
import 'package:kork/views/ticket_view.dart';

part '../bindings/main_binding.dart';
part '../controllers/main_controller.dart';
part '../widget/my_bottom_navigation.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    print(Get.textTheme.bodyLarge!.fontFamily);
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.screen,
        ),
      ),
      bottomNavigationBar: myBottomNavigation(),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: 57,
          height: 57,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Get.theme.colorScheme.onInverseSurface,
                Get.theme.colorScheme.primary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [.05, 1],
            ),
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.hardEdge,
          child: Center(
            child: Icon(
              Icons.add_circle_outline_sharp,
              color: Get.theme.colorScheme.tertiary,
              size: 26,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
