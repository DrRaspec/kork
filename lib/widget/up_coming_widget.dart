import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/routes/routes.dart';
import 'package:shimmer/shimmer.dart';

Widget upComingWidget(Map<String, dynamic> item) {
  var context = Get.context;
  if (context == null) return const SizedBox();
  return Material(
    child: InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () => Get.toNamed(Routes.eventDetail),
      child: Container(
        width: 198,
        height: 238,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Get.theme.colorScheme.primary,
              Get.theme.colorScheme.onInverseSurface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [.05, 1],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return buildPlaceholder();
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: Get.width,
                        height: Get.height,
                        color: Get.theme.colorScheme.tertiary,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            size: 24,
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                          // stops: [1,1]
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 10,
                          color: Get.theme.colorScheme.tertiary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item['location'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
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
                        const SizedBox(width: 8),
                        Text(
                          item['time'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // const SizedBox(height: 15),
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
      ),
    ),
  );
}

Widget buildPlaceholder() {
  return Shimmer.fromColors(
    baseColor: const Color(0xffF5EFFF),
    highlightColor: const Color(0xffE5D9F2),
    child: Container(
      width: Get.width,
      height: Get.height,
      color: const Color(0xFFCDC1FF),
    ),
  );
}
