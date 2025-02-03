import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/views/main_view.dart';

part '../controllers/event_controller.dart';
part '../bindings/event_binding.dart';
part '../widget/event_display_widget.dart';
part '../widget/event_widget.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.events,
          style: TextStyle(
            fontSize: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Get.theme.colorScheme.tertiary,
              size: 18,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_list,
              color: Get.theme.colorScheme.tertiary,
              size: 18,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                          width: Get.width * 0.5 - 20,
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
                                onTap: () => controller.isEvent.value = true,
                                splashFactory: NoSplash.splashFactory,
                                child: Container(
                                  height: Get.height,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.event,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Get.theme.colorScheme.tertiary,
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
                                onTap: () => controller.isEvent.value = false,
                                splashFactory: NoSplash.splashFactory,
                                child: Container(
                                  height: Get.height,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.up_coming,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Get.theme.colorScheme.tertiary,
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
    );
  }
}
