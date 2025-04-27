import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/screens/sign_up_view/first_signup/first_signup_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showCountriesDialog(bool isPhone) {
  var controller = Get.find<FirstSignupController>();
  var scrollController = ScrollController();
  var _searchResult = controller.countries.obs;

  scrollController.addListener(() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 50) {
      controller.loadMore();
    }
  });
  showDialog(
    context: Get.context!,
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: Get.width * 0.8,
            height: Get.height * 0.8,
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 59,
                    child: TextFormField(
                      onChanged: (value) {
                        _searchResult.value =
                            controller.countries.where((element) {
                          return element.name
                              .toLowerCase()
                              .contains(value.toLowerCase());
                        }).toList();
                        if (value.isEmpty) {
                          _searchResult.value = controller.countries;
                        }
                        // controller.searchCountries(value);
                      },
                      controller: controller.searchDialog,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.search_country,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.surfaceTint,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          if (index >= controller.currentLenght.value) {
                            return const SizedBox.shrink();
                          }
                          // var item = controller.countries[index];
                          var item = _searchResult[index];
                          return GestureDetector(
                            onTap: () {
                              if (isPhone) {
                                controller.country.value = item;
                              } else {
                                controller.selectedNationality.value =
                                    item.flag;
                                controller.nationality.text = item.name;
                              }
                              Get.back();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  item.flag,
                                  width: 26,
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: Text(
                                    item.name,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.tertiary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (isPhone) ...[
                                  const SizedBox(width: 30),
                                  Text(
                                    item.phoneCode,
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.tertiary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        // itemCount: controller.currentLenght.value,
                        itemCount: _searchResult.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
