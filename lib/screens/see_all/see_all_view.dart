import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/models/event_model.dart';
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
          controller.title,
        ),
      ),
      body: Obx(() {
        if (controller.status.value == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.status.value == Status.loadingMore) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.status.value == Status.error) {
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
        } else if (controller.status.value == Status.noData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/image/svg/no_data.svg',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No upcoming events',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        } else if (controller.status.value == Status.success) {
          if (controller.eventData.isEmpty) {
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
                    'No Upcoming events',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var eventData = Event.fromJson(controller.eventData[index]);
                return eventCard(eventData);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              itemCount: controller.eventData.length,
            ),
          );
        } else {
          // Default case: loading state
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
