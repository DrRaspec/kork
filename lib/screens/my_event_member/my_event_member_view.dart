import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'my_event_member_binding.dart';
part 'my_event_member_controller.dart';

class MyEventMemberView extends GetView<MyEventMemberViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: Obx(
          () => appbarTitle(controller.ticketType.isEmpty
              ? ''
              : '${controller.ticketType.value} ${AppLocalizations.of(context)!.ticket}'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.all_member,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var attendee = controller.matchAttendees[index];
                var ticketQty = controller.ticketDetail[index];
                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        attendee.profileUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(
                            Icons.error,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${attendee.firstName} ${attendee.lastName}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            attendee.email,
                            style: TextStyle(
                              fontSize: 10,
                              color: Get.theme.colorScheme.surfaceTint,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      ticketQty.qty.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: controller.matchAttendees.length,
            ),
          ],
        ),
      ),
    );
  }
}
