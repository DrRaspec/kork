import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/views/main_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var _mainController = Get.find<MainController>();
var _context = Get.context;
Widget buttomNavigationbar() {
  if (_context == null) {
    return const SizedBox.shrink();
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () {
          _mainController.currentIndex.value = 0;
        },
        child: SizedBox(
          height: 50,
          width: 50,
          child: Column(
            children: [
              const SizedBox(height: 4),
              SvgPicture.asset(
                'assets/image/svg/camera_indoor.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  _mainController.currentIndex.value == 0
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                  BlendMode.srcIn,
                ),
              ),
              Text(
                AppLocalizations.of(_context!)!.home,
                style: TextStyle(
                  fontSize: 10,
                  color: _mainController.currentIndex.value == 0
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          _mainController.currentIndex.value = 1;
        },
        child: SizedBox(
          height: 50,
          width: 50,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/image/svg/counter_7.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _mainController.currentIndex.value == 1
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                  BlendMode.srcIn,
                ),
              ),
              Text(
                AppLocalizations.of(_context!)!.event,
                style: TextStyle(
                  fontSize: 10,
                  color: _mainController.currentIndex.value == 1
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        width: 50,
        height: 50,
      ),
      GestureDetector(
        onTap: () {
          _mainController.currentIndex.value = 2;
        },
        child: SizedBox(
          height: 50,
          width: 50,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/image/svg/local_activity.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _mainController.currentIndex.value == 2
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                  BlendMode.srcIn,
                ),
              ),
              Text(
                AppLocalizations.of(_context!)!.ticket,
                style: TextStyle(
                  fontSize: 10,
                  color: _mainController.currentIndex.value == 2
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          _mainController.currentIndex.value = 3;
        },
        child: SizedBox(
          height: 50,
          width: 50,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/image/svg/person.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _mainController.currentIndex.value == 3
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                  BlendMode.srcIn,
                ),
              ),
              Text(
                AppLocalizations.of(_context!)!.profile,
                style: TextStyle(
                  fontSize: 10,
                  color: _mainController.currentIndex.value == 3
                      ? Get.theme.colorScheme.primary
                      : const Color(0xff404144),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
