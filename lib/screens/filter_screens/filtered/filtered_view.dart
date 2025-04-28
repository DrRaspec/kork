import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/helper/extension.dart';
import 'package:kork/helper/show_error_snack_bar.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/utils/status.dart';
import 'package:kork/widget/event_card.dart';

part 'filtered_controller.dart';

part 'filtered_binding.dart';

class FilteredView extends GetView<FilteredController> {
  const FilteredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.filter,
          style: TextStyle(
            fontSize: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              // const SizedBox(height: 16),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => SizedBox(
                    height: 32,
                    width: Get.width,
                    child: SingleChildScrollView(
                      // <-- ADD THIS
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.currentIndex.value = -1;
                            },
                            child: Container(
                              width: 135,
                              height: 32,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == -1
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.filterBackground,
                                border: Border.all(
                                  color: controller.currentIndex.value == -1
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.tertiary,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.filter_list,
                                      size: 20,
                                      color: controller.currentIndex.value == -1
                                          ? const Color(0xffEAE9FC)
                                          : Get.theme.colorScheme.tertiary,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.filter,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: controller.currentIndex.value ==
                                                -1
                                            ? const Color(0xffEAE9FC)
                                            : Get.theme.colorScheme.tertiary,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: controller.toggleExpansion,
                                      child: AnimatedRotation(
                                        turns: controller.isExpanded.value
                                            ? -0.25
                                            : 0.0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24,
                                          color: controller
                                                      .currentIndex.value ==
                                                  -1
                                              ? const Color(0xffEAE9FC)
                                              : Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (controller.isExpanded.value)
                            _buildCategoriesList(), // <-- REMOVE AnimatedContainer, just place the list directly
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => controller.status.value == Status.loading
                      ? SizedBox(
                          height: Get.height - 200,
                          child: const Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: List.generate(
                            controller.events.length,
                            (index) {
                              if (index.isOdd) {
                                return const SizedBox(height: 16);
                              }
                              // final itemIndex = index ~/ 2;
                              var item =
                                  Event.fromJson(controller.events[index]);
                              return eventCard(item);
                              // return const Text('Hello');
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return Row(
      children: List.generate(
        controller.argument.length,
        (index) {
          var category = controller.argument.keys.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(right: 7),
            child: GestureDetector(
              onTap: () {
                if (controller.currentIndex.value == index) {
                  controller.currentIndex.value = -1;
                  controller.fetchData();
                } else {
                  controller.currentIndex.value = index;
                  controller.fetchData(filter: category);
                }
              },
              child: Obx(
                () => Container(
                  width: 135,
                  height: 32,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == index
                        ? Get.theme.colorScheme.primary
                        : Get.theme.colorScheme.filterBackground,
                    border: Border.all(
                      color: controller.currentIndex.value == index
                          ? Get.theme.colorScheme.primary
                          : Get.theme.colorScheme.tertiary,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      controller.argument[category] is double
                          ? controller.argument[category].toStringAsFixed(0)
                          : controller.argument[category]
                              .toString()
                              .firstCapitalize(),
                      style: TextStyle(
                        fontSize: 12,
                        color: controller.currentIndex.value == index
                            ? const Color(0xffEAE9FC)
                            : Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
