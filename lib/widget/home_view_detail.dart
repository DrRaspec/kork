part of '../screens/main_screens/home/home_view.dart';

Widget homeViewDetail() {
  var controller = Get.find<HomeController>();
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        const SizedBox(height: 17),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              Get.isDarkMode
                  ? 'assets/image/logo.png'
                  : 'assets/image/light-logo.png',
              width: 35,
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.searchEvent);
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/image/svg/search-normal.svg',
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Get.theme.colorScheme.surfaceTint,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.search_event,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.surfaceTint,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 19),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.filter),
                child: Icon(
                  Icons.filter_list,
                  size: 24,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          // width: 380,
          height: 125,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Get.theme.colorScheme.onInverseSurface,
                Get.theme.colorScheme.primary,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Sam Sokunthea',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.view_ticket,
                          style: const TextStyle(
                            color: Color(0xffEAE9FC),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xffEAE9FC),
                          size: 8,
                        ),
                        SizedBox(width: Get.width * 0.01),
                        GestureDetector(
                          onTap: () => controller.updateScreen(3),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.view_profile,
                                style: const TextStyle(
                                  color: Color(0xffEAE9FC),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xffEAE9FC),
                                size: 8,
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
                onTap: () => controller.updateScreen(3),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 85,
                      height: 85,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          Get.isDarkMode
                              ? 'assets/image/logo.png'
                              : 'assets/image/light-logo.png',
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
  );
}
