import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/event_detail/event_detail.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: CustomScrollView(
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
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.search,
                        size: 24,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(width: 22),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.filter_list,
                        size: 24,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: bookedEventCard(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: bookedEventCard(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: Row(
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
                    child: Row(
                      children: List.generate(
                        controller.dummyData.length,
                        (index) {
                          final item = controller.dummyData[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 24), // Spacing between items
                            child: upComingWidget(item),
                          );
                        },
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
    );
  }
}
