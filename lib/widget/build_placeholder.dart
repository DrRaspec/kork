import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget buildPlaceholder(
    {double? width, double? height, double borderRadius = 0}) {
  return Shimmer.fromColors(
    baseColor: const Color(0xffF5EFFF),
    highlightColor: const Color(0xffE5D9F2),
    child: Container(
      width: width ?? Get.width,
      height: height ?? Get.height,
      decoration: BoxDecoration(
          color: const Color(0xFFCDC1FF),
          borderRadius: BorderRadius.circular(borderRadius)),
    ),
  );
}
