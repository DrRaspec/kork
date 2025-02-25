import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';

part '../../controllers/select_location_controller.dart';
part '../../bindings/select_location_binding.dart';

class SelectLocationView extends GetView<SelectLocationController> {
  const SelectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 17),
                Row(
                  children: [
                    Image.asset(
                      Get.isDarkMode
                          ? 'assets/image/logo.png'
                          : 'assets/image/light-logo.png',
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.skip,
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.select_current_location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/image/map_image.png',
                  width: 315,
                  height: 252,
                ),
                LayoutBuilder(builder: (context, constraits) {
                  return SizedBox(
                    width: constraits.maxWidth * 0.7,
                    child: Text(
                      AppLocalizations.of(context)!.please_choose_location,
                      style: TextStyle(
                        color: Get.theme.colorScheme.surfaceTint,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.mapView),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
