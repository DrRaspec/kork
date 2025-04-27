import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/up_coming_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget eventCard(Event event) {
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: Get.width,
        height: 147,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Get.theme.colorScheme.secondary,
                    const Color(0xff252525),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 1],
                ),
              ),
            ),
            Image.network(
              event.posterUrl,
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
              alignment: const Alignment(0, -0.3),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return buildPlaceholder();
              },
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(
                  Icons.error,
                  color: Color(0xffEAE9FC),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: Get.width,
        height: 147,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [
              const Color(0xff333333).withOpacity(0),
              const Color(0xff333333).withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 1],
          ),
        ),
        child: Container(
          // color: Colors.amber,
          height: 53,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 38,
                      height: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Get.theme.colorScheme.primary,
                            Get.theme.colorScheme.onInverseSurface,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          formatDayMonth(event.startDate),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xffEAE9FC),
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.eventName,
                            style: const TextStyle(
                              color: Color(0xffEAE9FC),
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            event.description,
                            style: const TextStyle(
                              color: Color(0xffEAE9FC),
                              fontSize: 8,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 10,
                                color: Color(0xffEAE9FC),
                              ),
                              const SizedBox(width: 5),
                              FutureBuilder<String>(
                                future: getCityName(event.location),
                                builder: (context, snapshot) => Text(
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? 'Loading...'
                                      : snapshot.hasError
                                          ? 'Error'
                                          : snapshot.data ?? 'Unknown City',
                                  style: const TextStyle(
                                    color: Color(0xffEAE9FC),
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 19),
                              SvgPicture.asset(
                                'assets/image/svg/pace.svg',
                                width: 8,
                                height: 8,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xffEAE9FC),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                formatTime(event.startTime),
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Color(0xffEAE9FC),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.eventDetail),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.more_detial,
                      style: const TextStyle(
                        color: Color(0xffEAE9FC),
                        fontSize: 8,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xffEAE9FC),
                      size: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Future<String> getCityName(LatLng latLng) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    Placemark place = placemarks.first;
    return place.locality ?? 'Unknown City';
  } catch (e) {
    print("Error getting city name: $e");
    return 'Error';
  }
}

String formatDayMonth(DateTime date) {
  final dayFormatter = DateFormat('d');
  final monthFormatter = DateFormat('MMM');

  final day = dayFormatter.format(date);
  final month = monthFormatter.format(date);

  return '$day\n$month';
}

String formatTime(String time) {
  return time.split(':').sublist(0, 2).join(':');
}

// Widget buildPlaceholder() {
//   return Shimmer.fromColors(
//     baseColor: const Color(0xffF5EFFF),
//     highlightColor: const Color(0xffE5D9F2),
//     child: Container(
//       width: Get.width,
//       height: Get.height,
//       color: const Color(0xFFCDC1FF),
//     ),
//   );
// }
