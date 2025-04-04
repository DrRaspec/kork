import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/utils/status.dart';

part 'filtered_controller.dart';
part 'filtered_binding.dart';

class FilteredView extends GetView<FilteredController> {
  const FilteredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              // const SizedBox(height: 16),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.filter,
                      style: TextStyle(
                        fontSize: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Get.theme.colorScheme.tertiary,
                      size: 24,
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                  width: Get.width,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Obx(
                      () => GestureDetector(
                        onTap: () => controller.currentIndex.value = index,
                        child: Container(
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            child: index == 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.filter_list,
                                        size: 20,
                                        color: controller.currentIndex.value ==
                                                index
                                            ? const Color(0xffEAE9FC)
                                            : Get.theme.colorScheme.tertiary,
                                      ),
                                      Text(
                                        controller.categories[index]
                                            ['categories'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: controller
                                                      .currentIndex.value ==
                                                  index
                                              ? const Color(0xffEAE9FC)
                                              : Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24,
                                          color: controller
                                                      .currentIndex.value ==
                                                  index
                                              ? const Color(0xffEAE9FC)
                                              : Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: Text(
                                      controller.categories[index]
                                          ['categories'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: controller.currentIndex.value ==
                                                index
                                            ? const Color(0xffEAE9FC)
                                            : Get.theme.colorScheme.tertiary,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 7),
                    itemCount: 3,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  // return eventCard();
                  return const Text('Hello');
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
