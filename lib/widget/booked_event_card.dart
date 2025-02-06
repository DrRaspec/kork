import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget bookedEventCard() {
  var isSilence = false.obs;
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  return Container(
    width: Get.width,
    height: 95,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Material(
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        onTap: () {
          print('fck');
        },
        child: Row(
          children: [
            Container(
              width: 110,
              height: 95,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                width: 38,
                height: 95,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xff333333),
                ),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    AppLocalizations.of(context)!.booked.toUpperCase(),
                    style: TextStyle(
                      color: Get.theme.colorScheme.tertiary,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 95,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Get.theme.colorScheme.tertiary,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Khmer New Year',
                              style: TextStyle(
                                fontSize: 10,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'idk duma didov dodod dummm dudu dokdok disdis jijouk jong jav jung jep',
                              style: TextStyle(
                                fontSize: 8,
                                color: Get.theme.colorScheme.surfaceTint,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 10,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Wat Phnom',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Get.theme.colorScheme.surfaceTint,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/image/svg/pace.svg',
                                  width: 10,
                                  height: 10,
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.colorScheme.surfaceTint,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '12:00AM - 12:00PM',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Get.theme.colorScheme.surfaceTint,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/image/svg/local_activity.svg',
                                  width: 10,
                                  height: 10,
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.colorScheme.surfaceTint,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '5.00\$',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Get.theme.colorScheme.surfaceTint,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/image/svg/Calendar.svg',
                                  width: 10,
                                  height: 10,
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.colorScheme.surfaceTint,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '14.Apr.2025',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Get.theme.colorScheme.surfaceTint,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () => isSilence.value = !isSilence.value,
                              child: Icon(
                                isSilence.value
                                    ? Icons.notifications_off_outlined
                                    : Icons.notifications_none,
                                size: 16,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.view_detail,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 8,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
