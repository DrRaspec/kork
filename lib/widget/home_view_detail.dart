part of '../views/home_view.dart';

Widget homeViewDetail() {
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  return SizedBox(
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
                                color: Get.theme.colorScheme.tertiary,
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
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
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
                              color: Get.theme.colorScheme.tertiary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
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
                              style: TextStyle(
                                fontSize: 14,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Sam Sokunthea',
                              style: TextStyle(
                                fontSize: 16,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.view_ticket,
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.tertiary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Get.theme.colorScheme.tertiary,
                                  size: 16,
                                ),
                                SizedBox(width: Get.width * 0.01),
                                GestureDetector(
                                  onTap: () => Get.toNamed(Routes.profile),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .view_profile,
                                        style: TextStyle(
                                          color: Get.theme.colorScheme.tertiary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Get.theme.colorScheme.tertiary,
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
                                color: Theme.of(context).colorScheme.tertiary,
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
  );
}
