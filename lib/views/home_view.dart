import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part '../controllers/home_controller.dart';
part '../bindings/home_binding.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.onInverseSurface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/image/Artboard 1 2.png',
                      width: 32,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.current_location,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.surfaceTint,
                              ),
                            ),
                            const SizedBox(width: 1),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 16,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ],
                        ),
                        Text(
                          'Phnom Penh',
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          color: Get.theme.colorScheme.tertiary,
                          size: 24,
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //     color: Get.theme.colorScheme.tertiary,
                        //   ),
                        //   borderRadius: BorderRadius.circular(30),
                        // ),
                        child: TextField(
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 8,
                              ),
                              child: SvgPicture.asset(
                                'assets/image/svg/search-normal.svg',
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Get.theme.colorScheme.tertiary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.search_event,
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.surfaceTint,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 19),
                    Icon(
                      Icons.filter_list,
                      size: 24,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
