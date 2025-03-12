import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/sign_up_view/map/map_view.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/event_textfield.dart';

part 'add_event_binding.dart';
part 'add_event_controller.dart';

class AddEventView extends GetView<AddEventViewController> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.event_information,
              style: TextStyle(
                fontSize: 16,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            eventTextField(
              textController: controller.nameController,
              errorMessage: controller.nameError.value,
              hintText: AppLocalizations.of(context)!.event_title,
              textFocus: controller.focusName,
            ),
            const SizedBox(height: 8),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.location,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => GestureDetector(
                          onTap: controller.getLocation,
                          child: eventTextField(
                            textController: controller.locationController,
                            errorMessage: controller.locationError.value,
                            hintText:
                                AppLocalizations.of(context)!.event_location,
                            textFocus: controller.focusLocation,
                            svgIcon: 'assets/image/svg/location.svg',
                            isEnable: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.category,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      eventTextField(
                        textController: controller.nameController,
                        errorMessage: controller.nameError.value,
                        hintText: AppLocalizations.of(context)!.event_category,
                        textFocus: controller.focusName,
                        svgIcon: 'assets/image/svg/category-2.svg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.getDate,
                        child: eventTextField(
                          textController: controller.startDateController,
                          errorMessage: controller.startDateError.value,
                          hintText: AppLocalizations.of(context)!.start_date,
                          textFocus: controller.focusStartDate,
                          svgIcon: 'assets/image/svg/calendar-3.svg',
                          isEnable: false,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.getDate(isStartDate: false),
                        child: eventTextField(
                          textController: controller.endDateController,
                          errorMessage: controller.endDateError.value,
                          hintText: AppLocalizations.of(context)!.end_date,
                          textFocus: controller.focusEndDate,
                          svgIcon: 'assets/image/svg/calendar-3.svg',
                          isEnable: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.getTime,
                        child: Obx(
                          () => eventTextField(
                            textController: controller.startTimeController,
                            errorMessage: controller.startTimeError.value,
                            hintText: AppLocalizations.of(context)!.start_time,
                            textFocus: controller.focusStartTime,
                            svgIcon: 'assets/image/svg/timer-start.svg',
                            isEnable: false,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.getTime(isStartTime: false),
                        child: Obx(
                          () => eventTextField(
                            textController: controller.endTimeController,
                            errorMessage: controller.endTimeError.value,
                            hintText: AppLocalizations.of(context)!.end_time,
                            textFocus: controller.focusEndTime,
                            svgIcon: 'assets/image/svg/timer-pause.svg',
                            isEnable: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.detail,
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          fontSize: 12,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 184,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Get.theme.colorScheme.tertiary,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TextField(
                    controller: controller.descriptionController,
                    focusNode: controller.focusDescription,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(
                      fontSize: 10,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.detail_guide,
                      hintStyle: TextStyle(
                        fontSize: 10,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.organizer_information,
              style: TextStyle(
                fontSize: 16,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.company,
              style: TextStyle(
                fontSize: 12,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            eventTextField(
              textController: controller.companyNameController,
              errorMessage: controller.companyNameError.value,
              hintText: AppLocalizations.of(context)!.company_name,
              textFocus: controller.focusCompanyName,
              svgIcon: 'assets/image/svg/timer-start.svg',
              isEnable: false,
            )
          ],
        ),
      ),
    );
  }
}
