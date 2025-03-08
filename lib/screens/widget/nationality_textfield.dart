import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/screens/sign_up_view/first_signup/first_signup_view.dart';
import 'package:kork/screens/widget/phone_number_validation.dart';
import 'package:kork/screens/widget/show_countries_dialog.dart';

Widget naionalityTextfield() {
  var controller = Get.find<FirstSignupController>();
  return GestureDetector(
    onTap: () {
      showCountriesDialog(false);
    },
    child: Container(
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
          SizedBox(
            width: 70,
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
                        controller.selectedNationality.value,
                        width: 24,
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
          Expanded(
            child: TextFormField(
              controller: controller.nationality,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                phoneNumberFormatter(),
              ],
              style: TextStyle(
                fontSize: 12,
                color: Get.theme.colorScheme.tertiary,
              ),
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 0,
                ),
                hintText: 'Cambodia',
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
    ),
  );
}
