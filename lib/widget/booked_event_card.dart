import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/widget/build_placeholder.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:kork/routes/routes.dart';

Widget bookedEventCard(
    {required Map<String, dynamic> event, bool isBooked = true}) {
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  if (isBooked) {
    BoughtTicket data = BoughtTicket.fromJson(event);
    return buildCard(data.posterUrl!);
  } else {
    HostedEvent data = HostedEvent.fromJson(event);
    return buildCard(data.posterUrl!);
  }
}

Widget buildCard(String imageUrl) {
  print('iamge url $imageUrl');
  return Container(
    width: Get.width,
    height: 100,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red,
    ),
    child: Container(
      width: Get.width,
      height: 138,
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.network(
        imageUrl,
        width: Get.width,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return buildPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    ),
  );
}
