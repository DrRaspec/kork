import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData;
import 'package:kork/helper/card_helper.dart';
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/utils/status.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/button_design.dart';

part 'add_new_payment_binding.dart';
part 'add_new_payment_controller.dart';

class AddNewPaymentView extends GetView<AddNewPaymentViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(result: controller.result),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.new_card,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 8,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.card_information,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                  border: controller.cardNumberError.isTrue
                      ? Border.all(color: const Color(0xffFF4D4D), width: 2)
                      : null,
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
                      color: Get.theme.colorScheme.surfaceTint,
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11),
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.card_number,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
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
            ),
            Obx(
              () => Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                  border: controller.cardHolderError.isTrue
                      ? Border.all(color: const Color(0xffFF4D4D), width: 2)
                      : null,
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
                      color: Get.theme.colorScheme.surfaceTint,
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11),
                          border: InputBorder.none,
                          hintText:
                              AppLocalizations.of(context)!.card_holder_name,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                        border: controller.expireDateError.isTrue
                            ? Border.all(
                                color: const Color(0xffFF4D4D),
                                width: 2,
                              )
                            : null,
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
                              onChanged: (_) => controller.onExpireDateChange(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                border: InputBorder.none,
                                hintText:
                                    AppLocalizations.of(context)!.expire_date,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(
                    () => Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                        border: controller.ccvError.isTrue
                            ? Border.all(
                                color: const Color(0xffFF4D4D),
                                width: 2,
                              )
                            : null,
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
                            color: Get.theme.colorScheme.surfaceTint,
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller.ccvController,
                              textAlignVertical: TextAlignVertical.center,
                              focusNode: controller.ccvFocus,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
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
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 11),
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!.ccv,
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                                counterText: "",
                                counterStyle: const TextStyle(fontSize: 0),
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
            const SizedBox(height: 16),
            GestureDetector(
              // onTap: () {
              //   controller.checkValidation();
              //   if (controller.ccvError.isFalse &&
              //       controller.expireDateError.isFalse &&
              //       controller.cardHolderError.isFalse &&
              //       controller.cardNumberError.isFalse) {
              //     Get.back();
              //   }
              // },
              onTap: controller.addCard,
              child: Obx(
                () => buttonDesign(
                  text: AppLocalizations.of(context)!.add_card,
                  status: controller.status.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
