import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget eventCategory() {
  var categories = ['Sport', 'Concert', 'Fashion'];
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
