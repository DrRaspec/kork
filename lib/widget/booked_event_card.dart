import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

Widget bookedEventCard() {
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  return Container(
    width: Get.width,
    height: 100,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Material(
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        onTap: () {
          Get.toNamed(Routes.bookedEvent);
        },
        child: Container(
          width: Get.width,
          height: 138,
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage(
                'assets/image/event_image.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          // child: Container(
          //   height: 138,
          //   width: 32,
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Get.theme.colorScheme.primary,
          //         Get.theme.colorScheme.onInverseSurface
          //       ],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          //   child: RotatedBox(
          //     quarterTurns: 3,
          //     child: Text(
          //       AppLocalizations.of(context)!.booked,
          //       style: const TextStyle(
          //         fontSize: 12,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xffEAE9FC),
          //       ),
          //       softWrap: false,
          //     ),
          //   ),
          // ),
        ),
      ),
    ),
  );
}
