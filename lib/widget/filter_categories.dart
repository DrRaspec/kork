import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/screens/filter_screens/filter/filter_view.dart';

var filterController = Get.find<FilterController>();

Widget filterCategories() {
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  var categories = [
    AppLocalizations.of(context)!.sport,
    AppLocalizations.of(context)!.concert,
    AppLocalizations.of(context)!.fashion,
    AppLocalizations.of(context)!.innovation,
    AppLocalizations.of(context)!.game,
  ];
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return Obx(
        () => GestureDetector(
          onTap: () {
            filterController.updateSelectCategory(
              index + 1,
            );
            filterController.filterItem['filter'] = categories[index];
          },
          child: Container(
            width: 133,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: filterController.selectCategory.value == index + 1
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.filterBackground,
              border: Border.all(
                color: filterController.selectCategory.value == index + 1
                    ? Get.theme.colorScheme.primary
                    : Get.theme.colorScheme.tertiary,
              ),
            ),
            child: Center(
              child: Text(
                categories[index],
                style: TextStyle(
                  color: filterController.selectCategory.value == index + 1
                      ? const Color(0xffEAE9FC)
                      : Get.theme.colorScheme.tertiary,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 7),
    itemCount: categories.length,
  );
}
