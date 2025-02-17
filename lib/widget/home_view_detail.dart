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
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.secondary,
            borderRadius: const BorderRadius.vertical(
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
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0x80EAE9FC),
                              ),
                            ),
                            const SizedBox(width: 1),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 16,
                              color: Color(0x80EAE9FC),
                            ),
                          ],
                        ),
                        const Text(
                          'Phnom Penh',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffEAE9FC),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        const Icon(
                          Icons.notifications_none,
                          color: Color(0xffEAE9FC),
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
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: Center(
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
                                  colorFilter: const ColorFilter.mode(
                                    Color(0x80EAE9FC),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              hintText:
                                  AppLocalizations.of(context)!.search_event,
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Color(0x80EAE9FC),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color(0xffEAE9FC),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Color(0xffEAE9FC)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 19),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.filter),
                      child: const Icon(
                        Icons.filter_list,
                        size: 24,
                        color: Color(0xffEAE9FC),
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
                                  onTap: () => Get.toNamed(Routes.profile),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .view_profile,
                                        style: const TextStyle(
                                          color: Color(0xffEAE9FC),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Get.theme.colorScheme.tertiary,
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
                        onTap: () => Get.toNamed(Routes.profile),
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
