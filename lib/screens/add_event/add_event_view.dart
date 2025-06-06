import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/helper/extension.dart';
import 'package:kork/helper/show_error_snack_bar.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/sign_up_view/map/map_view.dart';
import 'package:kork/utils/status.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/categories_dropdown.dart';
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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
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
                    Obx(
                      () => eventTextField(
                        textController: controller.nameController,
                        errorMessage: controller.nameError.value,
                        hintText: AppLocalizations.of(context)!.event_title,
                        textFocus: controller.focusName,
                      ),
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
                                      text: AppLocalizations.of(context)!
                                          .location,
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
                                    textController:
                                        controller.locationController,
                                    errorMessage:
                                        controller.locationError.value,
                                    hintText: AppLocalizations.of(context)!
                                        .event_location,
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
                                      text: AppLocalizations.of(context)!
                                          .category,
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
                                () => categoriesDropdown(
                                  categoryController:
                                      controller.categoryController,
                                  categoryError: controller.categoryError,
                                ),
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
                                child: Obx(
                                  () => eventTextField(
                                    textController:
                                        controller.startDateController,
                                    errorMessage:
                                        controller.startDateError.value,
                                    hintText: AppLocalizations.of(context)!
                                        .start_date,
                                    textFocus: controller.focusStartDate,
                                    svgIcon: 'assets/image/svg/calendar-3.svg',
                                    isEnable: false,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    controller.getDate(isStartDate: false),
                                child: Obx(
                                  () => eventTextField(
                                    textController:
                                        controller.endDateController,
                                    errorMessage: controller.endDateError.value,
                                    hintText:
                                        AppLocalizations.of(context)!.end_date,
                                    textFocus: controller.focusEndDate,
                                    svgIcon: 'assets/image/svg/calendar-3.svg',
                                    isEnable: false,
                                  ),
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
                                    textController:
                                        controller.startTimeController,
                                    errorMessage:
                                        controller.startTimeError.value,
                                    hintText: AppLocalizations.of(context)!
                                        .start_time,
                                    textFocus: controller.focusStartTime,
                                    svgIcon: 'assets/image/svg/timer-start.svg',
                                    isEnable: false,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    controller.getTime(isStartTime: false),
                                child: Obx(
                                  () => eventTextField(
                                    textController:
                                        controller.endTimeController,
                                    errorMessage: controller.endTimeError.value,
                                    hintText:
                                        AppLocalizations.of(context)!.end_time,
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
                              hintText:
                                  AppLocalizations.of(context)!.detail_guide,
                              hintStyle: TextStyle(
                                fontSize: 10,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 24),
                    // Text(
                    //   AppLocalizations.of(context)!.organizer_information,
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Get.theme.colorScheme.tertiary,
                    //   ),
                    // ),
                    const SizedBox(height: 24),
                    Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          // value: controller.selectedValue.value,
                          hint: Text(
                            AppLocalizations.of(context)!.ticket_information,
                            style: TextStyle(
                              color: Get.theme.colorScheme.tertiary,
                              fontSize: 16,
                            ),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Get.theme.colorScheme.tertiary,
                            size: 16,
                          ),
                          dropdownColor: Get.theme.scaffoldBackgroundColor,
                          style: TextStyle(
                            color: Get.theme.colorScheme.tertiary,
                            fontSize: 16,
                          ),
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            controller.selectedValue.value = newValue ?? '';
                            controller.updateControllers(newValue);
                          },
                          items: controller.ticketTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(
                                type,
                                style: TextStyle(
                                  color: Get.theme.colorScheme.tertiary,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.ticket_ammout,
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
                      () => SizedBox(
                        height: 50,
                        child: Row(
                          children: List.generate(
                            controller.ticketController.length * 2 - 1,
                            (index) {
                              if (index % 2 == 0) {
                                var itemIndex = index ~/ 2;
                                var ticketController = controller
                                    .ticketQuantityController[itemIndex];
                                var type = controller.types[itemIndex];

                                return Expanded(
                                  flex: 1,
                                  child: ticketAmount(
                                    ticketController,
                                    type,
                                  ),
                                );
                              } else {
                                return const SizedBox(width: 16);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.ticket_price,
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
                      () => SizedBox(
                        // height: 50,
                        child: Row(
                          children: List.generate(
                            controller.ticketPriceController.length,
                            (index) {
                              var ticketPriceController =
                                  controller.ticketPriceController[index];
                              var type = controller.types[index];

                              return Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ticketPrice(
                                        ticketPriceController,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        type,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color:
                                              Get.theme.colorScheme.surfaceTint,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.card_information,
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
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Get.theme.colorScheme.tertiary),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          SvgPicture.asset(
                            'assets/image/svg/card.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              Get.theme.colorScheme.tertiary,
                              BlendMode.srcIn,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 21,
                            color: const Color(0x80EAE9FC),
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller.cardNumberController,
                              textAlignVertical: TextAlignVertical.center,
                              focusNode: controller.cardNumberFocus,
                              onChanged: (_) => controller.onCardNumberChange(),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                // contentPadding:
                                //     const EdgeInsets.symmetric(vertical: 11),
                                border: InputBorder.none,
                                hintText:
                                    AppLocalizations.of(context)!.card_number,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => SvgPicture.asset(
                              controller.cardType.value == 'Visa'
                                  ? 'assets/image/svg/Visa.svg'
                                  : 'assets/image/svg/MasterCard.svg',
                              width: 38,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Get.theme.colorScheme.tertiary),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          SvgPicture.asset(
                            'assets/image/svg/profile.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              Get.theme.colorScheme.tertiary,
                              BlendMode.srcIn,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 21,
                            color: const Color(0x80EAE9FC),
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller.cardHolderController,
                              textAlignVertical: TextAlignVertical.center,
                              focusNode: controller.cardHolderFocus,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                // contentPadding:
                                //     const EdgeInsets.symmetric(vertical: 11),
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!
                                    .card_holder_name,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Get.theme.colorScheme.tertiary),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 16,
                              children: [
                                SvgPicture.asset(
                                  'assets/image/svg/calendar-2.svg',
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.colorScheme.tertiary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 21,
                                  color: const Color(0x80EAE9FC),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: controller.expireDateController,
                                    textAlignVertical: TextAlignVertical.center,
                                    focusNode: controller.expireDateFocus,
                                    onChanged: (_) =>
                                        controller.onExpireDateChange(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      // contentPadding:
                                      //     const EdgeInsets.symmetric(
                                      //         vertical: 11),
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)!
                                          .expire_date,
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Get.theme.colorScheme.surfaceTint,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Get.theme.colorScheme.tertiary),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 16,
                              children: [
                                SvgPicture.asset(
                                  'assets/image/svg/card.svg',
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.colorScheme.tertiary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 21,
                                  color: const Color(0x80EAE9FC),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: controller.ccvController,
                                    textAlignVertical: TextAlignVertical.center,
                                    focusNode: controller.ccvFocus,
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.length > 3) {
                                        return;
                                      }
                                    },
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      // contentPadding:
                                      //     const EdgeInsets.symmetric(
                                      //         vertical: 11),
                                      border: InputBorder.none,
                                      hintText:
                                          AppLocalizations.of(context)!.ccv,
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Get.theme.colorScheme.surfaceTint,
                                      ),
                                      counterText: "",
                                      counterStyle:
                                          const TextStyle(fontSize: 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.event_poster,
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
                    const SizedBox(height: 16),
                    Obx(
                      () => GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Container(
                          height: 114,
                          width: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: controller.selectedImage.value == null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/image/svg/Upload.svg',
                                      width: 18,
                                      colorFilter: ColorFilter.mode(
                                        Get.theme.colorScheme.surfaceTint,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .upload_event_poster,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Get.theme.colorScheme.tertiary,
                                      ),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(
                                    controller.selectedImage.value!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 65),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: controller.onSubmit,
                child: Container(
                  color: Get.theme.bottomNavigationBarTheme.backgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.publish,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: controller.status.value == Status.loading
                              ? null
                              : controller.onSubmit,
                          child: Container(
                            width: 140,
                            height: 30,
                            // padding: const EdgeInsets.symmetric(
                            //   horizontal: 24,
                            //   vertical: 8,
                            // ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Get.theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: controller.status.value == Status.loading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Color(0xffEAE9FC),
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.publish_event,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffEAE9FC),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget ticketAmount(TextEditingController controller, String text) {
  return SizedBox(
    width: double.infinity,
    child: TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Get.theme.colorScheme.surfaceTint,
        fontSize: 10,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Get.theme.colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        hintText: text,
        hintStyle: TextStyle(
          color: Get.theme.colorScheme.surfaceTint,
          fontSize: 10,
        ),
      ),
    ),
  );
}

Widget ticketPrice(TextEditingController controller) {
  var context = Get.context;
  if (context == null) return const SizedBox.shrink();
  return SizedBox(
    width: double.infinity,
    child: TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xffEAE9FC),
        fontSize: 10,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Get.theme.colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        hintText: AppLocalizations.of(context)!.price,
        hintStyle: const TextStyle(
          color: Color(0xffEAE9FC),
          fontSize: 10,
        ),
        fillColor: Get.theme.colorScheme.primary,
        filled: true,
      ),
    ),
  );
}
