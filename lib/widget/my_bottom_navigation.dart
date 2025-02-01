part of '../views/main_view.dart';

Widget myBottomNavigation() {
  var currentIndex = Get.find<MainController>().currentIndex;
  return Obx(
    () => BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/image/svg/camera_indoor.svg',
            width: 16,
            height: 18,
            colorFilter: ColorFilter.mode(
              currentIndex.value == 0
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.onInverseSurface,
              BlendMode.srcIn,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/image/svg/counter_7.svg',
            width: 16,
            height: 18,
            colorFilter: ColorFilter.mode(
              currentIndex.value == 1
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.onInverseSurface,
              BlendMode.srcIn,
            ),
          ),
          label: 'Event',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/image/svg/local_activity.svg',
            width: 16,
            height: 18,
            colorFilter: ColorFilter.mode(
              currentIndex.value == 2
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.onInverseSurface,
              BlendMode.srcIn,
            ),
          ),
          label: 'Ticket',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/image/svg/person.svg',
            width: 16,
            height: 18,
            colorFilter: ColorFilter.mode(
              currentIndex.value == 3
                  ? Get.theme.colorScheme.primary
                  : Get.theme.colorScheme.onInverseSurface,
              BlendMode.srcIn,
            ),
          ),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      // backgroundColor: const Color(0xffFAFAFA),
      currentIndex: currentIndex.value,
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        color: Get.theme.colorScheme.primary,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        color: Get.theme.colorScheme.onInverseSurface,
      ),
      selectedItemColor: Get.theme.colorScheme.primary,
      unselectedItemColor: Get.theme.colorScheme.onInverseSurface,
      onTap: (value) {
        currentIndex.value = value;
      },
    ),
  );
}
