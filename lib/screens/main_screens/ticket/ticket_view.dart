import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/helper/qr_code_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/event_detail/event_detail.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/utils/app_log_interceptor.dart';
import 'package:kork/widget/booked_event_card.dart';
import 'package:kork/widget/button_design.dart';
import 'package:kork/widget/up_coming_widget.dart';

part 'ticket_controller.dart';

part 'ticket_binding.dart';

class TicketView extends GetView<TicketController> {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => controller.onPopResult(),
      child: Scaffold(
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
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: controller.scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 17),
                      ),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!.ticket,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                            ),
                            Obx(
                              () => controller.isSelectionMode.value
                                  ? GestureDetector(
                                      onTap: controller.clearSelection,
                                      child: Container(
                                        width: 82,
                                        height: 19,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Get.theme.colorScheme.primary,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .scan_ticket,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xffEAE9FC),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 24),
                      ),
                      SliverToBoxAdapter(
                        child: Obx(
                          () => controller.buyedTickets.isNotEmpty
                              ? Column(
                                  children: [
                                    ...List.generate(
                                      controller.buyedTickets.length,
                                      (index) {
                                        var eventData = BoughtTicket.fromJson(
                                          controller.buyedTickets[index],
                                        );
                                        final ticketCode = eventData.ticketCode;
                                        final isSelected = controller
                                            .isTicketSelection(ticketCode);

                                        return Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Checkbox for selection
                                                if (controller
                                                    .isSelectionMode.value)
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (!controller
                                                          .isSelectionMode
                                                          .value) {
                                                        controller
                                                            .startSelection();
                                                      }
                                                      controller
                                                          .toggleTicketSelection(
                                                              ticketCode);
                                                      HapticFeedback
                                                          .selectionClick();
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 12),
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: isSelected
                                                              ? Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .primary
                                                              : Colors.grey,
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: isSelected
                                                            ? Get
                                                                .theme
                                                                .colorScheme
                                                                .primary
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                      child: isSelected
                                                          ? const Icon(
                                                              Icons.check,
                                                              size: 16,
                                                              color: const Color(
                                                                  0xffEAE9FC),
                                                            )
                                                          : null,
                                                    ),
                                                  ),
                                                // Event card
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (controller
                                                          .isSelectionMode
                                                          .value) {
                                                        controller
                                                            .toggleTicketSelection(
                                                                ticketCode);
                                                        HapticFeedback
                                                            .selectionClick();
                                                      } else {
                                                        Get.toNamed(
                                                          Routes.bookedEvent,
                                                          arguments: eventData,
                                                        );
                                                      }
                                                    },
                                                    onLongPress: () {
                                                      controller
                                                          .startSelection();
                                                      controller
                                                          .toggleTicketSelection(
                                                              ticketCode);
                                                      HapticFeedback
                                                          .mediumImpact();
                                                    },
                                                    child: bookedEventCard(
                                                      event: controller
                                                          .buyedTickets[index],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                          ],
                                        );
                                      },
                                    ),
                                    // Loading indicator
                                    controller.isLoading.value
                                        ? const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                      // const SliverToBoxAdapter(
                      //   child: SizedBox(height: 24),
                      // ),
                      SliverToBoxAdapter(
                        child: Obx(
                          () => controller.lastEvent.isEmpty
                              ? const SizedBox.shrink()
                              : GestureDetector(
                                  onTap: controller.seeAllEvent,
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .more_event,
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
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 24,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Obx(
                          () => controller.lastEvent.isEmpty
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: 238,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Obx(
                                      () => Row(
                                        children: List.generate(
                                          controller.lastEvent.length,
                                          (index) {
                                            final item = Event.fromJson(
                                                controller.lastEvent[index]);
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
                      ),
                      // const SliverToBoxAdapter(
                      //   child: SizedBox(height: 70),
                      // ),
                    ],
                  ),
                  Obx(
                    () {
                      return controller.isSelectionMode.value
                          ? Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => controller.genQrCode(context),
                                    child: buttonDesign(
                                      text: "Generate QR Code",
                                      width: Get.width * 0.6,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink();
                    },
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
