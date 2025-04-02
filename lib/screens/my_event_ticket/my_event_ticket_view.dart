import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'my_event_ticket_binding.dart';
part 'my_event_ticket_controller.dart';

class MyEventTicketView extends GetView<MyEventTicketViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle('Event Name'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectedIndex.value = 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: controller.selectedIndex.value == 0
                                ? Get.theme.colorScheme.primary
                                : Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.available,
                          style: TextStyle(
                            fontSize: 16,
                            color: controller.selectedIndex.value == 0
                                ? Get.theme.colorScheme.tertiary
                                : Get.theme.colorScheme.surfaceTint,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectedIndex.value = 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: controller.selectedIndex.value == 1
                                ? Get.theme.colorScheme.primary
                                : Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.sold,
                          style: TextStyle(
                            fontSize: 16,
                            color: controller.selectedIndex.value == 1
                                ? Get.theme.colorScheme.tertiary
                                : Get.theme.colorScheme.surfaceTint,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.ticket_available,
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.colorScheme.tertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '32',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffEAE9FC),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.myEventMember,
                      arguments: controller.eventTicketType[index],
                    ),
                    child: ticketAvailable(
                      ticketType: controller.eventTicketType[index],
                      ticketQty: index == 3 ? 0 : 4,
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: controller.eventTicketType.length,
                ),
                // ticketAvailable(
                //   ticketType: AppLocalizations.of(context)!.normal,
                //   ticketQty: 26,
                // ),
                // const SizedBox(height: 8),
                // ticketAvailable(
                //   ticketType: AppLocalizations.of(context)!.standard,
                //   ticketQty: 4,
                // ),
                // const SizedBox(height: 8),
                // ticketAvailable(
                //   ticketType: 'VIP',
                //   ticketQty: 4,
                // ),
                // const SizedBox(height: 8),
                // ticketAvailable(
                //   ticketType: 'VVIP',
                //   ticketQty: 0,
                // )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget ticketAvailable({required String ticketType, required int ticketQty}) {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ticketType,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xffEAE9FC),
            ),
          ),
          Text(
            ticketQty == 0
                ? AppLocalizations.of(Get.context!)!.sold_out
                : ticketQty.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0x80EAE9FC),
            ),
          ),
        ],
      ),
    );
  }
}
