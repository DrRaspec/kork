import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/screens/filter_screens/filter_location/filter_location.dart';
import 'package:kork/widget/filter_categories.dart';
import 'package:kork/widget/filter_date_widget.dart';

part 'filter_controller.dart';
part 'filter_binding.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    // DateTime? pickedDate;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.categories,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 32,
                      width: Get.width,
                      child: filterCategories(),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.time_date,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        Obx(
                          () => filterDateWidget(
                            AppLocalizations.of(context)!.today,
                          ),
                        ),
                        Obx(
                          () => filterDateWidget(
                            AppLocalizations.of(context)!.tomorrow,
                          ),
                        ),
                        Obx(
                          () => filterDateWidget(
                            AppLocalizations.of(context)!.this_weel,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Obx(
                      () => InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () async {
                          if (controller.filterItem.containsKey('date')) {
                            controller.pickedDate.value = DateTime.tryParse(
                              controller.filterItem['date'],
                            );
                          }
                          controller.pickedDate.value = await showDatePicker(
                            context: context,
                            initialDate:
                                controller.pickedDate.value ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2026, 1, 1),
                            builder: (context, child) {
                              return Theme(
                                data: Get.isDarkMode ? darkMode : lightMode,
                                child: child!,
                              );
                            },
                          );
                          if (controller.pickedDate.value != null) {
                            controller.filterItem['date'] =
                                DateFormat('yyyy-MM-dd').format(
                              controller.pickedDate.value!,
                            );
                            controller.selectDate.value = '';
                            print(controller.filterItem['date']);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Get.theme.colorScheme.filterBackground,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/image/svg/Calendar.svg',
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  Get.theme.colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                controller.pickedDate.value != null
                                    ? "${controller.pickedDate.value!.toLocal()}"
                                        .split(' ')[0]
                                    : AppLocalizations.of(context)!
                                        .choose_from_calender,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: Get.theme.colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .select_price_range,
                                style: TextStyle(
                                  color: Get.theme.colorScheme.tertiary,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${controller.currentRange.value.start.toStringAsFixed(0)}\$-${controller.currentRange.value.end.toStringAsFixed(0)}\$',
                                style: TextStyle(
                                  color: Get.theme.colorScheme.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RangeSlider(
                                  values: controller.currentRange.value,
                                  min: controller.minPrice,
                                  max: controller.maxPrice,
                                  divisions: 100,
                                  activeColor: Colors.red,
                                  inactiveColor: Colors.red.withOpacity(0.3),
                                  labels: RangeLabels(
                                    "\$${controller.currentRange.value.start.toInt()}",
                                    "\$${controller.currentRange.value.end.toInt()}",
                                  ),
                                  onChanged: (RangeValues values) {
                                    if (values.end - values.start >= 10) {
                                      controller.currentRange.value = values;
                                      controller.filterItem['min_price'] =
                                          controller.currentRange.value.start;
                                      controller.filterItem['max_price'] =
                                          controller.currentRange.value.end;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 16,
            ),
            color: Get.theme.bottomNavigationBarTheme.backgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (controller.filterItem.containsKey('filter')) {
                        controller.filterItem.remove('filter');
                      }
                      if (controller.filterItem.containsKey('date')) {
                        controller.filterItem.remove('date');
                      }
                      // if (controller.filterItem.containsKey('min_price')) {
                      //   controller.filterItem.remove('min_price');
                      // }
                      // if (controller.filterItem.containsKey('max_price')) {
                      //   controller.filterItem.remove('max_price');
                      // }
                      controller.selectCategory.value = -1;

                      controller.selectDate.value = '';
                      controller.pickedDate.value = null;

                      controller.currentRange.value = const RangeValues(20, 30);

                      // controller.filterItem.clear();
                      controller.filterItem['min_price'] = 20;
                      controller.filterItem['max_price'] = 30;

                      controller.selectedLocation.value = '';
                      print('filterItem: ${controller.filterItem}');
                    },
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.reset,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('filterItem: ${controller.filterItem}');
                      Get.toNamed(
                        Routes.filtered,
                        arguments: controller.filterItem,
                      );
                    },
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Get.theme.colorScheme.secondary,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.apply,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffEAE9FC),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
