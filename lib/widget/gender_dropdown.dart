import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:kork/views/sign_up_view/first_signup_view.dart';

Widget genderDropdown() {
  var controller = Get.find<FirstSignupController>();
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }

  return DropdownButtonFormField2<String>(
    value: controller.selectedGender.value,
    isExpanded: true,
    items: [
      DropdownMenuItem(
        value: AppLocalizations.of(context)!.male,
        child: Text(
          AppLocalizations.of(context)!.male,
        ),
      ),
      DropdownMenuItem(
        value: AppLocalizations.of(context)!.female,
        child: Text(
          AppLocalizations.of(context)!.female,
        ),
      ),
      DropdownMenuItem(
        value: AppLocalizations.of(context)!.other,
        child: Text(
          AppLocalizations.of(context)!.other,
        ),
      ),
    ],
    onChanged: (value) {
      if (value != null || value!.isNotEmpty) {
        controller.selectedGender.value = value;
        controller.genderError.value = '';
      }
    },
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 8,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Get.theme.colorScheme.tertiary,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: controller.genderError.isNotEmpty
              ? Get.theme.colorScheme.primary
              : Get.theme.colorScheme.tertiary,
          width: 1.5,
        ),
      ),
    ),
    hint: Text(
      AppLocalizations.of(context)!.male_or_female,
      style: TextStyle(
        color: Get.theme.colorScheme.surfaceTint,
        fontSize: 12,
      ),
    ),
    iconStyleData: IconStyleData(
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 24,
        color: controller.genderError.isNotEmpty
            ? Get.theme.colorScheme.primary
            : Get.theme.colorScheme.tertiary,
      ),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Get.theme.colorScheme.secondary,
      ),
      maxHeight: 100,
      elevation: 2,
      padding: EdgeInsets.zero,
      // offset: const Offset(0, 5),
    ),
    style: TextStyle(
      color: Get.theme.colorScheme.tertiary,
      fontSize: 12,
    ),
    buttonStyleData: const ButtonStyleData(
      padding: EdgeInsets.only(right: 8),
    ),
    menuItemStyleData: const MenuItemStyleData(
      height: 35, // Adjust as needed
      padding: EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 16,
      ),
    ),
  );
}
