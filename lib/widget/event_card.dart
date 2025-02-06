part of '../views/event_view.dart';

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Get.theme.colorScheme.secondary,
              const Color(0xff252525),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 1],
          ),
          image: const DecorationImage(
            image: NetworkImage(
              'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
            ),
            fit: BoxFit.cover,
          ),
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
              const Color(0xff252525).withOpacity(0.9),
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
                      child: Center(
                        child: Text(
                          '14\nApr',
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.tertiary,
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
                            style: TextStyle(
                              color: Get.theme.colorScheme.tertiary,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet fried siLorem ipsum dolor sit amet fried si',
                            style: TextStyle(
                              color: Get.theme.colorScheme.surfaceTint,
                              fontSize: 8,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 10,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Camp nou',
                                style: TextStyle(
                                  color: Get.theme.colorScheme.surfaceTint,
                                  fontSize: 8,
                                ),
                              ),
                              const SizedBox(width: 19),
                              SvgPicture.asset(
                                'assets/image/svg/pace.svg',
                                width: 8,
                                height: 8,
                                colorFilter: ColorFilter.mode(
                                  Get.theme.colorScheme.tertiary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '7PM',
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
                      style: TextStyle(
                        color: Get.theme.colorScheme.surfaceTint,
                        fontSize: 8,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Get.theme.colorScheme.surfaceTint,
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
