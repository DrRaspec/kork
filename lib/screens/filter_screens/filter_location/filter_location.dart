import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/filter_screens/filter/filter_view.dart';

part 'filter_location_controller.dart';
part 'filter_location_binding.dart';

class FilterLocation extends GetView<FilterLocationController> {
  const FilterLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // const SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 16,
              //   ),
              // ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back(
                          result: controller.selectedValue.value,
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.select_map,
                          style: TextStyle(
                            fontSize: 20,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 14),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 39,
                  child: TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        controller
                            .updateSearchLocation(controller.cambodiaProvinces);
                      } else {
                        var filtered =
                            controller.cambodiaProvinces.entries.where((entry) {
                          final locationName =
                              entry.value?.toString().toLowerCase().trim() ??
                                  '';
                          final searchTerm = value.toLowerCase().trim();
                          return locationName.contains(searchTerm);
                        }).fold<Map<String, dynamic>>({}, (map, entry) {
                          map[entry.key] = entry.value;
                          return map;
                        });
                        controller.updateSearchLocation(filtered);
                      }
                    },
                    controller: controller.searchController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      fillColor: Get.theme.colorScheme.secondary,
                      hintText: 'Search your location in...',
                      hintStyle: TextStyle(
                        color: Get.theme.colorScheme.surfaceTint,
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Get.theme.colorScheme.tertiary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: Text(
                  AppLocalizations.of(context)!.browsing_in,
                  style: TextStyle(
                    fontSize: 10,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 18,
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  final itemList = controller.searchLocation.entries.toList();
                  if (index >= itemList.length) return const SizedBox();
                  final location = itemList[index].value;

                  return Obx(
                    () => InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        if (controller.selectedValue.value == location) {
                          controller.selectedValue.value = '';
                        } else {
                          controller.selectedValue.value = location;
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Get.theme.colorScheme.tertiary,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.cambodia,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Get.theme.colorScheme.surfaceTint,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          controller.selectedValue.value == location
                              ? Icon(
                                  Icons.check_circle_outline_outlined,
                                  size: 24,
                                  color: Get.theme.colorScheme.tertiary,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: controller.searchLocation.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
