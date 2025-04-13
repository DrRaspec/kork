import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/checkout/checkout_view.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kork/widget/booked_event_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

part 'your_ticket_binding.dart';
part 'your_ticket_controller.dart';

class YourTicketView extends GetView<YourTicketViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.your_ticket,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context)!.save_ticket,
              style: TextStyle(
                fontSize: 20,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              AppLocalizations.of(context)!.please_kindly_save,
              style: TextStyle(
                fontSize: 10,
                color: Get.theme.colorScheme.surfaceTint,
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 254,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.5,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      controller._currentIndex.value = index;
                    },
                  ),
                  items: controller.imageList.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: Get.width * 0.5,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.imageList.asMap().entries.map((entry) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller._currentIndex.value == entry.key
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              spacing: Get.width * 0.05,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => controller.getGenerateQrCode(context),
                  child: Container(
                    width: 125,
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/image/svg/download.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            Color(0xffEAE9FC),
                            BlendMode.srcIn,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 11,
                          color: const Color(0xffEAE9FC),
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.download,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xffEAE9FC),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 125,
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/image/svg/camera.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            Color(0xffEAE9FC),
                            BlendMode.srcIn,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 11,
                          color: const Color(0xffEAE9FC),
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.screenshot,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xffEAE9FC),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: controller.seeAllBookedEvent,
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.book_ticket,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.see_all,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 8,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 8),
            // bookedEventCard(),
            // const SizedBox(height: 8),
            // bookedEventCard(),
            const SizedBox(height: 16),
            Obx(
              () => Column(
                children: List.generate(
                  controller.buyedTickets.length,
                  (index) {
                    return Column(
                      children: [
                        bookedEventCard(event: controller.buyedTickets[index]),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
