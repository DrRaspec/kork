import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/views/filter_views/filter_location.dart';
import 'package:kork/widget/filter_categories.dart';
import 'package:kork/widget/filter_date_widget.dart';

part '../../controllers/filter_controllers/filter_controller.dart';
part '../../bindings/filter_bindings/filter_binding.dart';

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
                    const SizedBox(height: 24),
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
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          if (controller.filterItem.containsKey('time_date')) {
                            controller.pickedDate.value = DateTime.tryParse(
                                controller.filterItem['time_date']);
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
                            controller.filterItem['time_date'] =
                                DateFormat('yyyy-MM-dd').format(
                              controller.pickedDate.value!,
                            );
                            controller.selectDate.value = '';
                            print(
                              controller.filterItem['time_date'],
                            );
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
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.location,
                        style: TextStyle(
                          fontSize: 16,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => Material(
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: controller.navigateToFilterLocation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: Get.theme.colorScheme.filterBackground,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Get.theme.colorScheme.tertiary
                                            .withOpacity(
                                          .2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Get.theme.colorScheme
                                                .filterBackground
                                            : const Color(0xffFAFAFA),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/image/svg/map-pin.svg',
                                      width: 16,
                                      height: 16,
                                      colorFilter: ColorFilter.mode(
                                        Get.theme.colorScheme.primary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  controller.selectedLocation.value == ''
                                      ? 'No location selected'
                                      : controller.selectedLocation.value,
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
                    ),
                    const SizedBox(height: 24),
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
                                '${controller.currentRange.value.start.toStringAsFixed(0)}\$-${controller.currentRange.value.end.toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: Get.theme.colorScheme.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 75),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RangeSlider(
                                  values: controller.currentRange.value,
                                  min: controller.minPrice,
                                  max: controller.maxPrice,
                                  divisions: 100, // Steps for smooth dragging
                                  activeColor: Colors.red,
                                  inactiveColor: Colors.red.withOpacity(0.3),
                                  labels: RangeLabels(
                                    "\$${controller.currentRange.value.start.toInt()}",
                                    "\$${controller.currentRange.value.end.toInt()}",
                                  ),
                                  onChanged: (RangeValues values) {
                                    if (values.end - values.start >= 10) {
                                      controller.currentRange.value = values;
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
            color: const Color(0xFFFAFAFA),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.selectCategory.value = 0;
                      controller.selectDate.value = '';

                      controller.pickedDate.value = null;

                      controller.currentRange.value =
                          const RangeValues(80, 120);

                      controller.filterItem.value = <String, dynamic>{};

                      controller.selectedLocation.value = '';
                    },
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Get.theme.colorScheme.secondary,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.reset,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Get.theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.filtered),
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
