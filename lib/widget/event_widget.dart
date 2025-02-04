part of '../views/event_view.dart';

Widget eventWidget() {
  var context = Get.context;
  var isEvent = Get.find<EventController>().isEvent;
  if (context == null) {
    return const SizedBox();
  }
  return isEvent.value == true
      ? Column(
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.sports,
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.see_all,
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 8,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 380,
              height: 311,
              child: eventDisplayWidget(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.fashion,
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.see_all,
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 8,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 380,
              height: 311,
              child: eventDisplayWidget(),
            ),
          ],
        )
      : SizedBox(
          width: Get.width,
          height: Get.height * 0.73,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 202,
                height: 202,
                decoration: const BoxDecoration(
                  color: Color(0xffDADADA),
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 45,
                    left: 22,
                  ),
                  child: SvgPicture.asset(
                    'assets/image/svg/schedule1.svg',
                    width: 170,
                    height: 170,
                  ),
                ),
              ),
              const SizedBox(height: 31),
              Text(
                'No Upcoming event',
                style: TextStyle(
                  fontSize: 24,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ],
          ),
        );
}
