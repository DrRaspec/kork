import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/add_event/add_event_view.dart';

Widget categoriesDropdown() {
  var context = Get.context;
  if (context == null) return const SizedBox.shrink();
  var controller = Get.find<AddEventViewController>();
  return SizedBox(
    width: double.infinity,
    height: 40,
    child: DropdownButtonFormField2(
      items: [
        DropdownMenuItem(
          value: AppLocalizations.of(context)!.sport,
          child: Text(
            AppLocalizations.of(context)!.sport,
          ),
        ),
        DropdownMenuItem(
          value: AppLocalizations.of(context)!.concert,
          child: Text(
            AppLocalizations.of(context)!.concert,
          ),
        ),
        DropdownMenuItem(
          value: AppLocalizations.of(context)!.fashion,
          child: Text(
            AppLocalizations.of(context)!.fashion,
          ),
        ),
        DropdownMenuItem(
          value: AppLocalizations.of(context)!.game,
          child: Text(
            AppLocalizations.of(context)!.game,
          ),
        ),
        DropdownMenuItem(
          value: AppLocalizations.of(context)!.innovation,
          child: Text(
            AppLocalizations.of(context)!.innovation,
          ),
        ),
      ],
      onChanged: (value) {
        if (value != null || value!.isNotEmpty) {
          controller.categoryController.text = value;
          controller.categoryError.value = '';
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
            color: controller.categoryError.isNotEmpty
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
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              controller.categoryError.isNotEmpty
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
    ),
  );
}
