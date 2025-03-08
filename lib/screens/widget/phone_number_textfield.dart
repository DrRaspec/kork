import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/screens/sign_up_view/first_signup/first_signup_view.dart';
import 'package:kork/screens/widget/phone_number_validation.dart';
import 'package:kork/screens/widget/show_countries_dialog.dart';

Widget phoneNumberTextfield() {
  var controller = Get.find<FirstSignupController>();
  return Container(
    height: 39,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: Get.theme.colorScheme.tertiary,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showCountriesDialog(true);
          },
          child: SizedBox(
            // padding: const EdgeInsets.symmetric(
            //   vertical: 11,
            // ),
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 24,
                  color: Get.theme.colorScheme.tertiary,
                ),
                controller.country.value == null
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : SvgPicture.asset(
                        controller.country.value!.flag,
                        width: 24,
                      ),
                Text(
                  controller.country.value == null
                      ? '...'
                      : controller.country.value!.phoneCode,
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller.phoneNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              phoneNumberFormatter(),
            ],
            style: TextStyle(
              fontSize: 12,
              color: Get.theme.colorScheme.tertiary,
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 0,
              ),
              hintText: '87 290 123',
              hintStyle: TextStyle(
                fontSize: 12,
                color: Get.theme.colorScheme.surfaceTint,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
