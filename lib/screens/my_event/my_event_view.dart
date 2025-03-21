import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/booked_event_card.dart';

part 'my_event_binding.dart';
part 'my_event_controller.dart';

class MyEventView extends GetView<MyEventViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.my_event),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.hosted_event,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Get.theme.colorScheme.tertiary,
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
                      '2',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Column(
                children: [
                  Divider(color: Get.theme.colorScheme.surfaceTint),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.myEventDetail),
                    child: bookedEventCard(),
                  ),
                  // const SizedBox(height: 16),
                ],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: 2,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.addEvent),
              child: Container(
                height: 40,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  spacing: 16,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 24,
                      color: Color(0xffEAE9FC),
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.add_event,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffEAE9FC),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16,
                      color: Color(0xffEAE9FC),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget
}
