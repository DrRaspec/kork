import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

Widget eventCategory() {
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
      return GestureDetector(
        onTap: () => Get.toNamed(
          Routes.seeAll,
          arguments: categories[index],
        ),
        child: Container(
          margin: EdgeInsets.only(left: index == 0 ? 16 : 0),
          width: 133,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.theme.colorScheme.secondary,
            border: Border.all(
              color: const Color(0xffEAE9FC),
            ),
          ),
          child: Center(
            child: Text(
              categories[index],
              style: const TextStyle(
                color: Color(0xffEAE9FC),
                fontSize: 12,
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
