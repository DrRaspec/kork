import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/models/event_detail_model.dart';
import 'package:kork/screens/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
            const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context)!.save_ticket,
              style: TextStyle(
                fontSize: 20,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.please_kindly_save,
              style: TextStyle(
                fontSize: 10,
                color: Get.theme.colorScheme.surfaceTint,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 254,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
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
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.imageList.asMap().entries.map((entry) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller._currentIndex.value == entry.key
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
