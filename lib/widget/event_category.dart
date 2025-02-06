import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget eventCategory() {
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  var categories = [
    AppLocalizations.of(context)!.sport,
    AppLocalizations.of(context)!.concert,
    AppLocalizations.of(context)!.fashion,
  ];
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(left: index == 0 ? 36 : 0),
        width: 133,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Get.theme.colorScheme.primary,
          border: Border.all(
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
        child: Center(
          child: Text(
            categories[index],
            style: TextStyle(
              color: Get.theme.colorScheme.tertiary,
              fontSize: 12,
            ),
          ),
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 7),
    itemCount: categories.length,
  );
}
