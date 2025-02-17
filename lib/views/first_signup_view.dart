import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:kork/modal/countries.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/widget/city_dropdown.dart';
import 'package:kork/widget/nationality_textfield.dart';
import 'package:kork/widget/phone_number_textfield.dart';

part '../controllers/first_signup_controller.dart';
part '../bindings/first_signup_binding.dart';

class FirstSignupView extends GetView<FirstSignupController> {
  const FirstSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 17),
                Image.asset(
                  Get.isDarkMode
                      ? 'assets/image/logo.png'
                      : 'assets/image/light-logo.png',
                  width: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.sign_up,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // const SizedBox(height: 16),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.fullname,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: controller.firstName,
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                  hintText:
                                      AppLocalizations.of(context)!.first_name,
                                  hintStyle: TextStyle(
                                    color: Get.theme.colorScheme.surfaceTint,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: TextFormField(
                                  controller: controller.lastName,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.2,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Get.theme.colorScheme.tertiary,
                                      ),
                                    ),
                                    hintText:
                                        AppLocalizations.of(context)!.last_name,
                                    hintStyle: TextStyle(
                                      color: Get.theme.colorScheme.surfaceTint,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.gender,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: DropdownButtonFormField2<String>(
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
                            if (value != null) {
                              controller.selectedGender.value = value;
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
                          ),
                          hint: Text(
                            AppLocalizations.of(context)!.male_or_female,
                            style: TextStyle(
                              color: Get.theme.colorScheme.surfaceTint,
                              fontSize: 12,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: const Color(0xffF7F8F9),
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
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.dob,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: TextFormField(
                            controller: controller.dob,
                            readOnly: true,
                            onTap: showCalenderDialog,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.2,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Get.theme.colorScheme.tertiary,
                                  width: 1.5,
                                ),
                              ),
                              // focusedBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(5),
                              //   borderSide: BorderSide(
                              //     color: Get.theme.colorScheme.tertiary,
                              //     width: 1.5,
                              //   ),
                              // ),
                              hintText: AppLocalizations.of(context)!.birthday,
                              hintStyle: TextStyle(
                                color: Get.theme.colorScheme.surfaceTint,
                                fontSize: 12,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                  horizontal: 16,
                                ),
                                child: SvgPicture.asset(
                                  'assets/image/svg/Calendar.svg',
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.colorScheme.tertiary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.phone_number,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => phoneNumberTextfield(),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.nationality,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => naionalityTextfield(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.province_City,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Get.theme.colorScheme.tertiary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: controller.cityProvince,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                      hintText: AppLocalizations.of(context)!
                                          .province_City,
                                      hintStyle: TextStyle(
                                        color:
                                            Get.theme.colorScheme.surfaceTint,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.district_khan,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Get.theme.colorScheme.tertiary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    controller: controller.districtKhan,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                      hintText: AppLocalizations.of(context)!
                                          .province_City,
                                      hintStyle: TextStyle(
                                        color:
                                            Get.theme.colorScheme.surfaceTint,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.commune_sangkat,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: controller.communeSangkat,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.province_City,
                            hintStyle: TextStyle(
                              color: Get.theme.colorScheme.surfaceTint,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () => Get.toNamed(
                          Routes.signup,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.next,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xffC9131E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCalenderDialog() async {
    controller.pickedDate.value = await showDatePicker(
      context: Get.context!,
      initialDate: controller.pickedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 1, 1),
      builder: (context, child) {
        return Theme(
          data: Get.isDarkMode ? darkMode : lightMode,
          child: child!,
        );
      },
    );
    if (controller.pickedDate.value != null) {
      controller.dob.text =
          DateFormat('yyyy-MM-dd').format(controller.pickedDate.value!);
    }
  }
}
