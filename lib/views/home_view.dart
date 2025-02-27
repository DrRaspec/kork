import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/views/filter_view.dart';
import 'package:kork/views/main_view.dart';
import 'package:kork/widget/event_category.dart';
import 'package:kork/widget/get_free_voucher_widget.dart';
import 'package:kork/widget/up_coming_widget.dart';

part '../controllers/home_controller.dart';
part '../bindings/home_binding.dart';
part '../widget/home_view_detail.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx < 10) {
                controller.mainControler.currentIndex.value = 1;
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(0),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.upcoming_event,
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
                        const SizedBox(height: 24),
                        SizedBox(
                          width: Get.width,
                          height: 238,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = controller.dummyData[index];
                              return upComingWidget(item);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 24),
                            itemCount: controller.dummyData.length,
                          ),
                        ),
                        const SizedBox(height: 23),
                        getFreeVoucher(),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.nearby_you,
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
                        const SizedBox(height: 24),
                        SizedBox(
                          width: Get.width,
                          height: 238,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = controller.dummyData[index];
                              return upComingWidget(item);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 24),
                            itemCount: controller.dummyData.length,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.showing,
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
                        const SizedBox(height: 24),
                        SizedBox(
                          width: Get.width,
                          height: 238,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = controller.dummyData[index];
                              return upComingWidget(item);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 24),
                            itemCount: controller.dummyData.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
