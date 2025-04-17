import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/screens/event_detail/event_detail.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:kork/widget/booked_event_card.dart';
import 'package:kork/widget/up_coming_widget.dart';

part 'ticket_controller.dart';

part 'ticket_binding.dart';

class TicketView extends GetView<TicketController> {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
            controller.fetchLastData();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 17),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.ticket,
                          style: TextStyle(
                            fontSize: 20,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                SliverToBoxAdapter(
                  child: Obx(
                    () => Column(
                      children: List.generate(
                          controller.buyedTickets.length,
                        (index) {
                          // var event = BoughtTicket.fromJson(
                          //     controller.buyedTickets[index]);
                          return Column(
                            children: [
                              bookedEventCard(
                                event: controller.buyedTickets[index],
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // const SliverToBoxAdapter(
                //   child: SizedBox(height: 24),
                // ),
                SliverToBoxAdapter(
                  child: Obx(
                    () => controller.buyedTickets.isEmpty
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.more_event,
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
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 238,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                        () => Row(
                          children: List.generate(
                            controller.lastEvent.length,
                            (index) {
                              final item =
                                  Event.fromJson(controller.lastEvent[index]);
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 24,
                                ),
                                child: upComingWidget(item),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
