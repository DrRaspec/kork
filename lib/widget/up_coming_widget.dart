import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/models/event_detail_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:shimmer/shimmer.dart';

var _location = ''.obs;

String extractTime(String time) {
  List<String> parts = time.split(' ');
  parts.removeAt(0);
  return parts.join(' ');
}

void getLocationAddress(String street) async {
  try {
    List<String> parts = street.split(',');
    double latitude = double.parse(parts[0].trim());
    double longitude = double.parse(parts[1].trim());

    final placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    if (placemarks.isNotEmpty) {
      final mark = placemarks.last;
      _location.value = mark.subLocality ??
          mark.subAdministrativeArea ??
          mark.administrativeArea ??
          mark.locality ??
          mark.country ??
          'Unknown _location';
      // print(display_location.value);
      print("location: ${_location.value}");
    } else {
      _location.value = 'Address not found';
    }
  } catch (e) {
    print('Error fetching address: $e');
  }
}

Widget upComingWidget(Map<String, dynamic> items) {
  var context = Get.context;
  if (context == null) return const SizedBox();
  var item = EventDetailModel.fromMap(items);
  getLocationAddress(item.street);
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () => Get.toNamed(Routes.eventDetail, arguments: item),
      child: Container(
        width: 198,
        height: 238,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Get.theme.colorScheme.primary,
              Get.theme.colorScheme.onInverseSurface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [.05, 1],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      item.image,
                      fit: BoxFit.cover,
                      alignment: Alignment(0, -0.3),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return buildPlaceholder();
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: Get.width,
                        height: Get.height,
                        color: const Color(0xffEAE9FC),
                        child: Center(
                          child: Icon(
                            Icons.error,
                            size: 24,
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      width: 31,
                      height: 29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Get.theme.colorScheme.primary,
                            const Color(0xff1C1818),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // stops: [1,1]
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Text(
                            item.date.substring(0, item.date.length - 5),
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color(0xffEAE9FC),
                            ),
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 31,
                      height: 29,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Get.theme.colorScheme.primary,
                            const Color(0xff1C1818),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.bookmark_border_rounded,
                          size: 18,
                          color: Color(0xffEAE9FC),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          color: Color(0xffEAE9FC),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 10,
                          color: Color(0xffEAE9FC),
                        ),
                        const SizedBox(width: 8),
                        Obx(
                          () => Text(
                            _location.value,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xffEAE9FC),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/image/svg/pace.svg',
                          width: 10,
                          colorFilter: const ColorFilter.mode(
                            Color(0xffEAE9FC),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          extractTime(item.time),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xffEAE9FC),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.view_detail,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xffEAE9FC),
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Padding(
                            padding: EdgeInsets.only(top: 1.5),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color(0xffEAE9FC),
                              size: 8,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildPlaceholder() {
  return Shimmer.fromColors(
    baseColor: const Color(0xffF5EFFF),
    highlightColor: const Color(0xffE5D9F2),
    child: Container(
      width: Get.width,
      height: Get.height,
      color: const Color(0xFFCDC1FF),
    ),
  );
}
