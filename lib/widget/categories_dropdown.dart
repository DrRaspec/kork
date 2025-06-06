import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget categoriesDropdown({
  required TextEditingController categoryController,
  required RxString categoryError,
  String? initialValue,
}) {
  var context = Get.context;
  if (context == null) return const SizedBox.shrink();

  // Define available values list for validation
  final availableValues = [
    AppLocalizations.of(context)!.sport,
    AppLocalizations.of(context)!.concert,
    AppLocalizations.of(context)!.fashion,
    AppLocalizations.of(context)!.game,
    AppLocalizations.of(context)!.innovation,
  ];

  // Set initial value if provided and controller is empty
  if (initialValue != null && categoryController.text.isEmpty) {
    // Validate initial value
    if (availableValues.contains(initialValue)) {
      categoryController.text = initialValue;
    } else {
      // Default to first item if invalid initial value
      categoryController.text = availableValues.first;
    }
  }

  // Validate current controller value
  if (categoryController.text.isNotEmpty &&
      !availableValues.contains(categoryController.text)) {
    // Reset to first option if current value is invalid
    categoryController.text = availableValues.first;
  }

  return SizedBox(
    width: double.infinity,
    height: 40,
    child: DropdownButtonFormField2(
      value: categoryController.text.isNotEmpty
          ? categoryController.text
          : availableValues.first,
      items: availableValues.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null && value.isNotEmpty) {
          categoryController.text = value.toString();
          categoryError.value = '';
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
            color: categoryError.isNotEmpty
                ? Get.theme.colorScheme.primary
                : Get.theme.colorScheme.tertiary,
            width: 1.5,
          ),
        ),
      ),
      hint: Text(
        AppLocalizations.of(context)!.event_category,
        style: TextStyle(
          color: Get.theme.colorScheme.surfaceTint,
          fontSize: 12,
        ),
      ),
      iconStyleData: IconStyleData(
        icon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SvgPicture.asset(
            'assets/image/svg/category-2.svg',
            width: 14,
            height: 14,
            colorFilter: ColorFilter.mode(
              categoryError.isNotEmpty
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.tertiary,
              BlendMode.srcIn,
            ),
          ),
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Get.isDarkMode
              ? Get.theme.colorScheme.secondary
              : Get.theme.appBarTheme.backgroundColor,
        ),
        maxHeight: 100,
        elevation: 2,
        padding: EdgeInsets.zero,
      ),
      style: TextStyle(
        color: Get.theme.colorScheme.tertiary,
        fontSize: 12,
      ),
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 35,
        padding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
      ),
    ),
  );
}
