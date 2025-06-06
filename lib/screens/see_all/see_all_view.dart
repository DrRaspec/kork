import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/helper/extension.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/utils/status.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:kork/widget/event_card.dart';

part 'see_all_binding.dart';
part 'see_all_controller.dart';

class SeeAllView extends GetView<SeeAllViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          controller.title.firstCapitalize(),
        ),
      ),
      body: Obx(
        () {
          if (controller.status.value == Status.loading &&
              controller.eventData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.status.value == Status.error &&
              controller.eventData.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/image/svg/error.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'An error occurred. Please try again.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.fetchData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (controller.status.value == Status.noData &&
              controller.eventData.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/image/svg/schedule1.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No events',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                // Show items
                if (index < controller.eventData.length) {
                  var eventData = Event.fromJson(controller.eventData[index]);
                  return GestureDetector(
                    onTap: () =>
                        Get.toNamed(Routes.eventDetail, arguments: eventData),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: eventCard(eventData),
                    ),
                  );
                } else if (controller.status.value == Status.loadingMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return null;
              },
              itemCount: controller.eventData.length +
                  (controller.status.value == Status.loadingMore ? 1 : 0),
            );
          }
        },
      ),
    );
  }
}
