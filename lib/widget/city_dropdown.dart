import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/views/sign_up_view/first_signup_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget cityDropdown() {
  var controller = Get.find<FirstSignupController>();
  return SizedBox(
    height: 40,
    child: DropdownButtonFormField2<String>(
      value: controller.cityProvince.text,
      isExpanded: true,
      items: cities.map(
        (city) {
          return DropdownMenuItem(
            value: city,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                city,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
            ),
          );
        },
      ).toList(),
      onChanged: (value) {
        if (value != null) {}
      },
      selectedItemBuilder: (context) => cities.map(
        (e) {
          return Row(
            children: [
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                e,
                style: const TextStyle(fontSize: 12, height: 1.2),
              ),
            ],
          );
        },
      ).toList(),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.tertiary,
            width: 1.5,
          ),
        ),
      ),
      hint: Container(
        margin: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(_context)!.phnom_penh,
              style: TextStyle(
                color: Get.theme.colorScheme.surfaceTint,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      iconStyleData: const IconStyleData(
        iconSize: 0, // Hide the default icon
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Get.theme.colorScheme.filterBackground,
        ),
        maxHeight: 100,
        width: Get.width - 32,
        elevation: 2,
        padding: EdgeInsets.zero,

        // offset: const Offset(0, 5),
      ),
      style: TextStyle(
        color: Get.theme.colorScheme.tertiary,
        fontSize: 12,
        height: 1.5,
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

var _context = Get.context!;
var cities = [
  AppLocalizations.of(_context)!.phnom_penh,
  AppLocalizations.of(_context)!.banteay_meanchey,
  AppLocalizations.of(_context)!.battambang,
  AppLocalizations.of(_context)!.kampong_cham,
  AppLocalizations.of(_context)!.kampong_chhnang,
  AppLocalizations.of(_context)!.kampong_speu,
  AppLocalizations.of(_context)!.kampong_thom,
  AppLocalizations.of(_context)!.kampot,
  AppLocalizations.of(_context)!.kandal,
  AppLocalizations.of(_context)!.koh_kong,
  AppLocalizations.of(_context)!.kratie,
  AppLocalizations.of(_context)!.mondulkiri,
  AppLocalizations.of(_context)!.preah_vihear,
  AppLocalizations.of(_context)!.prey_veng,
  AppLocalizations.of(_context)!.pursat,
  AppLocalizations.of(_context)!.rattanakiri,
  AppLocalizations.of(_context)!.siem_reap,
  AppLocalizations.of(_context)!.preah_sihanouk,
  AppLocalizations.of(_context)!.stung_treng,
  AppLocalizations.of(_context)!.svay_rieng,
  AppLocalizations.of(_context)!.takeo,
  AppLocalizations.of(_context)!.oddar_meanchey,
  AppLocalizations.of(_context)!.kep,
  AppLocalizations.of(_context)!.pailin,
  AppLocalizations.of(_context)!.tboung_khmum,
];
