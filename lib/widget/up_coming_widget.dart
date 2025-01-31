import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/views/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget upComingWidget() {
  final homeController = Get.find<HomeController>();
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      final item = homeController.dummyData[index];
      return Container(
        width: 198,
        height: 238,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color(0xff252525),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        width: 31,
                        height: 29,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Get.theme.colorScheme.primary,
                              const Color(0xff1C1818),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Text(
                              item['date'],
                              style: TextStyle(
                                fontSize: 8,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 31,
                        height: 29,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Get.theme.colorScheme.primary,
                              const Color(0xff1C1818),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.bookmark_border_rounded,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item['title'],
                        style: TextStyle(
                          color: Get.theme.colorScheme.tertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 10,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                        Text(
                          item['location'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/image/svg/pace.svg',
                          width: 10,
                          colorFilter: ColorFilter.mode(
                            Get.theme.colorScheme.tertiary,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          item['time'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.view_detail,
                            style: TextStyle(
                              fontSize: 10,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.5),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Get.theme.colorScheme.tertiary,
                              size: 8,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 24),
    itemCount: homeController.dummyData.length,
  );
}
