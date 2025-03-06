import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'contact_organizer_binding.dart';
part 'contact_organizer_controller.dart';

class ContactOrganizerView extends GetView<ContactOrganizerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.contact_organizer,
          style: TextStyle(
            fontSize: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.your_name,
              style: TextStyle(
                fontSize: 12,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
              child: Center(
                child: Text(
                  'I Hate File',
                  style: TextStyle(
                    color: Get.theme.colorScheme.surfaceTint,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.message,
              style: TextStyle(
                color: Get.theme.colorScheme.tertiary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: controller.messageCtrl,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
