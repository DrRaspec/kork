import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/event_category.dart';
import 'package:kork/widget/up_coming_widget.dart';

part '../controllers/home_controller.dart';
part '../bindings/home_binding.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.onInverseSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                SizedBox(
                  height: 320,
                  child: Stack(
                    children: [
                      Container(
                        height: 309,
                        decoration: const BoxDecoration(
                          color: Color(0xff252525),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(35),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            AppLocalizations.of(context)!
                                                .current_location,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                            ),
                                          ),
                                          const SizedBox(width: 1),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 16,
                                            color:
                                                Get.theme.colorScheme.tertiary,
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
                                      child: TextField(
                                        controller: TextEditingController(),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          prefixIconConstraints:
                                              const BoxConstraints(
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
                                              AppLocalizations.of(context)!
                                                  .search_event,
                                          hintStyle: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                              const SizedBox(height: 24),
                              Container(
                                // width: 380,
                                height: 125,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Get.theme.colorScheme.secondary,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .welcome,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Sam Sokunthea',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .view_ticket,
                                                style: TextStyle(
                                                  color: Get.theme.colorScheme
                                                      .tertiary,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Get
                                                    .theme.colorScheme.tertiary,
                                                size: 16,
                                              ),
                                              SizedBox(width: Get.width * 0.01),
                                              GestureDetector(
                                                onTap: () =>
                                                    Get.toNamed(Routes.profile),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .view_profile,
                                                      style: TextStyle(
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .tertiary,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Get.theme
                                                          .colorScheme.tertiary,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.toNamed(Routes.profile),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 85,
                                            height: 85,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onInverseSurface,
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/image/Artboard 1 2.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: 32,
                          width: Get.width,
                          child: eventCategory(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 29),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.upcoming_event,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            AppLocalizations.of(context)!.see_all,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 8,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: Get.width,
                  height: 158,
                  child: upComingWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
