import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/helper/bookmark_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/utils/status.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/event_card.dart';

part 'bookmark_binding.dart';
part 'bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.bookmark,
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () => Get.toNamed(Routes.searchEvent),
        //     child: Icon(
        //       Icons.search,
        //       color: Get.theme.colorScheme.tertiary,
        //       size: 24,
        //     ),
        //   ),
        //   const SizedBox(width: 22),
        //   GestureDetector(
        //     onTap: () {
        //       Get.toNamed(Routes.filter);
        //     },
        //     child: Icon(
        //       Icons.filter_list,
        //       color: Get.theme.colorScheme.tertiary,
        //       size: 24,
        //     ),
        //   ),
        //   const SizedBox(width: 16),
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Obx(
            () {
              if (controller.status.value == Status.loading &&
                  controller.bookmarks.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.status.value == Status.error &&
                  controller.bookmarks.isEmpty) {
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
                          controller.fetchBookmark();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (controller.status.value == Status.noData &&
                  controller.bookmarks.isEmpty) {
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
                        'No bookmark events',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              } else {
                return buildData();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildData() {
    return ListView.separated(
      shrinkWrap: true,
      controller: controller.scrollController,
      itemBuilder: (context, index) {
        if (index < controller.bookmarks.length) {
          var item = Event.fromJson(controller.bookmarks[index]);
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.eventDetail, arguments: item),
            child: eventCard(item),
          );
        } else if (controller.status.value == Status.loadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return null;
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: controller.bookmarks.length +
          (controller.status.value == Status.loadingMore ? 1 : 0),
    );
  }
}
