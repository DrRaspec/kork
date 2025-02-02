part of '../views/event_view.dart';

Widget eventDisplayWidget() {
  return ListView.separated(
    itemBuilder: (context, index) {
      return Stack(
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
                  stops: const [0.1, 1]),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 39,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Get.theme.colorScheme.primary,
                                  Get.theme.colorScheme.onInverseSurface,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Center(
                                child: Text(
                                  '14 Apr',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Get.theme.colorScheme.tertiary,
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Real Madrid ${AppLocalizations.of(context)!.vs} Barcelona',
                                  style: const TextStyle(
                                    color: Color(0xffD7D7D7),
                                    fontSize: 10,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  'Lorem ipsum dolor sit amet fried siLorem ipsum dolor sit amet fried si',
                                  style: TextStyle(
                                    color: Color(0xffC4C4C4),
                                    fontSize: 8,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.more_detial,
                          style: const TextStyle(
                            color: Color(0xffC4C4C4),
                            fontSize: 8,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xffC4C4C4),
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
    },
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemCount: 3,
  );
}
