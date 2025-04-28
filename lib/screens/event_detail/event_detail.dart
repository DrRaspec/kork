import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kork/helper/bookmark_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/build_placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

part 'event_detail_controller.dart';
part 'event_detail_binding.dart';

class EventDetail extends GetView<EventDetailController> {
  const EventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 225,
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                controller.eventData.posterUrl,
                              ),
                              fit: BoxFit.cover,
                              alignment: const Alignment(0, -0.3),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(
                                    result: controller.isMarked.value,
                                  ),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Get.theme.colorScheme.secondary,
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      size: 20,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.markEvent,
                                  child: Obx(
                                    () => Container(
                                      width: 32,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Get.theme.colorScheme.secondary,
                                      ),
                                      child: controller.isMarked.value
                                          ? const Icon(
                                              Icons.bookmark,
                                              size: 21,
                                              color: Color(0xffE5A000),
                                            )
                                          : Icon(
                                              Icons.bookmark_border_outlined,
                                              size: 21,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 56),
                              Text(
                                controller.eventData.eventName,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Get.theme.colorScheme.tertiary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 41,
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: Color(0xffEAE9FC),
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  GestureDetector(
                                    onTap: () => controller.openInGoogleMaps(),
                                    child: Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.location.value,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: Get.width - 97,
                                            ),
                                            child: Text(
                                              controller.displayLocation.value,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Get.theme.colorScheme
                                                    .surfaceTint,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 41,
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 20,
                                      color: Color(0xffEAE9FC),
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.startDate,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${controller.startDay} ${controller.startTime.value} - ${controller.endTime.value}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Get
                                                .theme.colorScheme.surfaceTint,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      // color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      controller.eventData.user.profileUrl!,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress != null) {
                                          return buildPlaceholder();
                                        }
                                        return child;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${controller.eventData.user.firstName} ${controller.eventData.user.lastName}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Get.theme.colorScheme.tertiary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.organizer,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Get.theme.colorScheme.surfaceTint,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Text(
                                AppLocalizations.of(context)!.ticket_type,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 30,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => ticketType(
                                    controller
                                        .eventData.tickets[index].ticketType,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 15),
                                  itemCount:
                                      controller.eventData.tickets.length,
                                ),
                              ),
                              // const SizedBox(height: 28),
                              // Text(
                              //   AppLocalizations.of(context)!.contact_organizer,
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w500,
                              //     color: Get.theme.colorScheme.tertiary,
                              //   ),
                              // ),
                              // const SizedBox(height: 24),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () => Get.toNamed(
                              //         Routes.contactOrganizer,
                              //         arguments: false,
                              //       ),
                              //       child: Text(
                              //         AppLocalizations.of(context)!.contact,
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w500,
                              //           color: Get.theme.colorScheme.tertiary,
                              //         ),
                              //       ),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () => Get.toNamed(
                              //         Routes.contactOrganizer,
                              //         arguments: true,
                              //       ),
                              //       child: Text(
                              //         AppLocalizations.of(context)!.report,
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w500,
                              //           color: Get.theme.colorScheme.tertiary,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 24),
                              Text(
                                AppLocalizations.of(context)!.about_event,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                controller.eventData.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => controller.attendees.isEmpty
                          ? const SizedBox.shrink()
                          : attendees(context: context),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: Get.width,
              // height: 57,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: Get.theme.bottomNavigationBarTheme.backgroundColor,
              ),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Get.toNamed(
                  Routes.checkout,
                  arguments: controller.eventData,
                ),
                child: Container(
                  width: 153,
                  height: 39,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Get.theme.colorScheme.primary,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.buy_now,
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
    );
  }

  Widget ticketType(String text) {
    return Material(
      child: Container(
        height: 30,
        width: Get.width / controller.eventData.tickets.length - 19.3,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primary,
          border: Border.all(
            color: Get.theme.colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xffEAE9FC),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget attendees({required BuildContext context}) {
    return Positioned(
      top: 200,
      child: Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Container(
          width: Get.width * 0.75,
          height: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 76,
                child: Stack(
                  children: [
                    controller.attendees.length < 3
                        ? const SizedBox(width: 34, height: 34)
                        : Positioned(
                            left: 40,
                            top: 0,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Get.theme.colorScheme.secondary,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    controller.attendees[2].profileUrl ??
                                        'unknown',
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                                border: Border.all(
                                  width: 1.42,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ),
                    controller.attendees.length < 2
                        ? const SizedBox(width: 34, height: 34)
                        : Positioned(
                            top: 0,
                            left: controller.attendees.length != 2 ? 20 : 32,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    controller.attendees[1].profileUrl ??
                                        'unknown',
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                                border: Border.all(
                                  width: 1.42,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ),
                    Positioned(
                      top: 0,
                      left: controller.attendees.length != 1 ? 0 : 20,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              controller.attendees[0].profileUrl ?? 'unknown',
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          border: Border.all(
                            width: 1.42,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                controller.attendeeNumber.isNotEmpty
                    ? controller.attendeeNumber.value
                    : 'Unknown',
                style: TextStyle(
                  fontSize: 15,
                  color: Get.theme.colorScheme.tertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(
                  Routes.eventMember,
                  arguments: controller.attendees,
                ),
                child: Container(
                  width: 73,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.see_all,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xffEAE9FC),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
