import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/filter_screens/filter/filter_view.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/screens/main_screens/event/event_view.dart';
import 'package:kork/widget/event_category.dart';
import 'package:kork/widget/get_free_voucher_widget.dart';
import 'package:kork/widget/up_coming_widget.dart';

part 'home_controller.dart';
part 'home_binding.dart';
part '../../../widget/home_view_detail.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.processUserData();
            controller.fetchUpComingData();
            controller.fetchShowingData();
          },
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => FocusScope.of(context).unfocus(),
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx < -10) {
                      controller.updateScreen(1);
                    }
                  },
                  child: Column(
                    children: [
                      homeViewDetail(),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 32,
                        width: Get.width,
                        child: eventCategory(),
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          children: [
                            Obx(
                              () => controller.categories['showing'] == null ||
                                      controller.categories['showing']!.isEmpty
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: GestureDetector(
                                        onTap: controller.categoryScreen,
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .upcoming_event,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Get
                                                    .theme.colorScheme.tertiary,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .see_all,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Get
                                                    .theme.colorScheme.tertiary,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 8,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 24),
                            Obx(() => showItem('upcoming')),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: getFreeVoucher(),
                            ),
                            const SizedBox(height: 24),
                            Obx(
                              () => controller.categories['showing'] == null ||
                                      controller.categories['showing']!.isEmpty
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .showing,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .see_all,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 8,
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 24),
                            Obx(() => showItem('showing')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget showItem(String key) {
    if (controller.categories[key] == null ||
        controller.categories[key]!.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: double.infinity,
      height: 238,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = controller.categories[key]![index];
          return upComingWidget(item);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemCount: controller.categories[key]!.length,
      ),
    );
  }
}
