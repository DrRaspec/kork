import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/booked_event_card.dart';

part '../controllers/ticket_controller.dart';
part '../bindings/ticket_binding.dart';

class TicketView extends GetView<TicketController> {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                Row(
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
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.book_ticket,
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
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 8,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: Get.width,
                  height: 95,
                  child: bookedEventCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
