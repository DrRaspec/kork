import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

part 'event_controller.dart';
part 'event_binding.dart';
part '../../../widget/event_card.dart';
part '../../../widget/event_widget.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     AppLocalizations.of(context)!.events,
      //     style: TextStyle(
      //       fontSize: 20,
      //       color: Get.theme.colorScheme.tertiary,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.search,
      //         color: Get.theme.colorScheme.tertiary,
      //         size: 18,
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Get.toNamed(Routes.filter);
      //       },
      //       icon: Icon(
      //         Icons.filter_list,
      //         color: Get.theme.colorScheme.tertiary,
      //         size: 18,
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.events,
                      style: TextStyle(
                        fontSize: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.searchEvent),
                    child: Icon(
                      Icons.search,
                      color: Get.theme.colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 22),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.filter);
                    },
                    child: Icon(
                      Icons.filter_list,
                      color: Get.theme.colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Container(
                        width: Get.width,
                        height: 39,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff252525),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Obx(
                          () => Stack(
                            children: [
                              AnimatedAlign(
                                alignment: controller.isEvent.value
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: Container(
                                  width: math.max(Get.width * 0.5 - 20, 0),
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Get.theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () =>
                                            controller.isEvent.value = true,
                                        splashFactory: NoSplash.splashFactory,
                                        child: Container(
                                          height: Get.height,
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)!.event,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xffEAE9FC),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () =>
                                            controller.isEvent.value = false,
                                        splashFactory: NoSplash.splashFactory,
                                        child: Container(
                                          height: Get.height,
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .up_coming,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xffEAE9FC),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      Obx(
                        () => eventWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
