import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/utils/event_categories.dart';
import 'package:kork/widget/event_card.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

part 'event_controller.dart';
part 'event_binding.dart';
// part '../../../widget/event_widget.dart';

class EventView extends GetView<EventController> {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.fetchAllCategoryEvents();
            controller.fetchUpComingEvent();
          },
          child: Column(
            children: [
              const SizedBox(height: 17),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.events,
                      style: TextStyle(
                        fontSize: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.searchEvent),
                      child: Icon(
                        Icons.search,
                        color: Get.theme.colorScheme.tertiary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 22),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.filter),
                      child: Icon(
                        Icons.filter_list,
                        color: Get.theme.colorScheme.tertiary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        _buildToggleBar(context),
                        const SizedBox(height: 17),
                        Obx(
                          () => controller.isEvent.value
                              ? _buildEventsView(context)
                              : controller.upComingEvent.isEmpty
                                  ? _buildNoUpcomingEventsView()
                                  : _loadUpcomingEvent(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleBar(BuildContext context) {
    return Container(
      width: Get.width,
      height: 39,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff252525),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Obx(
        () => Stack(
          children: [
            AnimatedAlign(
              alignment: controller.isEvent.value
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                width: math.max(Get.width * 0.5 - 20, 0),
                height: 35,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.isEvent.value = true,
                      splashFactory: NoSplash.splashFactory,
                      child: Container(
                        height: Get.height,
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.event,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xffEAE9FC),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.isEvent.value = false,
                      splashFactory: NoSplash.splashFactory,
                      child: Container(
                        height: Get.height,
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.up_coming,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xffEAE9FC),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsView(BuildContext context) {
    return Column(
      children: EventCategories.values
          .where((category) => controller.hasEventsForCategory(category))
          .map((category) {
        String title;
        switch (category) {
          case EventCategories.sport:
            title = AppLocalizations.of(context)!.sports;
            break;
          case EventCategories.fashion:
            title = AppLocalizations.of(context)!.fashion;
            break;
          case EventCategories.concert:
            title = AppLocalizations.of(context)!.concert;
            break;
          case EventCategories.game:
            title = AppLocalizations.of(context)!.game;
            break;
          case EventCategories.innovation:
            title = AppLocalizations.of(context)!.innovation;
            break;
        }
        return _buildCategorySection(context, category, title);
      }).toList(),
    );
  }

  Widget _buildCategorySection(
      BuildContext context, EventCategories category, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.seeAll, arguments: category.name),
              child: Row(
                children: [
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
          ],
        ),
        const SizedBox(height: 24),
        Obx(() {
          if (controller.isLoading.value) {
            return _buildLoadingShimmer();
          }

          final events = controller.getEventsForCategory(category);
          if (events.isEmpty) {
            return _buildNoEventsPlaceholder();
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => SizedBox(
              width: Get.width,
              height: 174,
              child: GestureDetector(
                onTap: () {
                  print('event data ${events[index]}');
                  Get.toNamed(Routes.eventDetail, arguments: events[index]);
                },
                child: eventCard(events[index]),
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: events.length > 3 ? 3 : events.length,
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              width: Get.width,
              height: 174,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoEventsPlaceholder() {
    return Container(
      width: Get.width,
      height: 174,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No events available',
            style: TextStyle(color: Get.theme.colorScheme.tertiary),
          ),
          Text(
            'Check connection or try again later',
            style:
                TextStyle(color: Get.theme.colorScheme.tertiary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _loadUpcomingEvent() {
    if (controller.isLoading.value) {
      return _buildLoadingShimmer();
    }

    final upcomingEvent = controller.upComingEvent;
    if (upcomingEvent.isEmpty) {
      return _buildNoEventsPlaceholder();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var upcomingEvent = Event.fromJson(controller.upComingEvent[index]);
        return SizedBox(
          width: Get.width,
          height: 174,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.eventDetail, arguments: upcomingEvent);
            },
            child: eventCard(upcomingEvent),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemCount: controller.upComingEvent.length,
    );
  }

  Widget _buildNoUpcomingEventsView() {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.73,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 202,
            height: 202,
            decoration: const BoxDecoration(
              color: Color(0xffDADADA),
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.hardEdge,
            child: Container(
              margin: const EdgeInsets.only(
                top: 45,
                left: 22,
              ),
              child: SvgPicture.asset(
                'assets/image/svg/schedule1.svg',
                width: 170,
                height: 170,
              ),
            ),
          ),
          const SizedBox(height: 31),
          Text(
            'No Upcoming event',
            style: TextStyle(
              fontSize: 24,
              color: Get.theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
