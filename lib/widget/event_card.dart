part of '../views/main_view/event_view.dart';

Widget eventCard() {
  var context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: Get.width,
        height: 147,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Get.theme.colorScheme.secondary,
                    const Color(0xff252525),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 1],
                ),
              ),
            ),
            Image.network(
              'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return buildPlaceholder();
              },
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(
                  Icons.error,
                  color: Color(0xffEAE9FC),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: Get.width,
        height: 147,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Get.theme.colorScheme.secondary.withOpacity(0),
              Get.theme.colorScheme.secondary.withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 1],
          ),
        ),
        child: Container(
          // color: Colors.amber,
          height: 53,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Get.theme.colorScheme.primary,
                            Get.theme.colorScheme.onInverseSurface,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '14\nApr',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffEAE9FC),
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Real Madrid ${AppLocalizations.of(context)!.vs} Barcelona',
                            style: const TextStyle(
                              color: Color(0xffEAE9FC),
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Lorem ipsum dolor sit amet fried siLorem ipsum dolor sit amet fried si',
                            style: TextStyle(
                              color: Color(0xffEAE9FC),
                              fontSize: 8,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 10,
                                color: Color(0xffEAE9FC),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Camp nou',
                                style: TextStyle(
                                  color: Color(0xffEAE9FC),
                                  fontSize: 8,
                                ),
                              ),
                              const SizedBox(width: 19),
                              SvgPicture.asset(
                                'assets/image/svg/pace.svg',
                                width: 8,
                                height: 8,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xffEAE9FC),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                '7PM',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xffEAE9FC),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.more_detial,
                      style: const TextStyle(
                        color: Color(0xffEAE9FC),
                        fontSize: 8,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xffEAE9FC),
                      size: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
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
