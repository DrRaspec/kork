import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/models/event_detail_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/build_placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

part 'event_detail_controller.dart';
part 'event_detail_binding.dart';

class EventDetail extends GetView<EventDetailController> {
  const EventDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 225,
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                controller.eventData.image,
                              ),
                              fit: BoxFit.cover,
                              alignment: const Alignment(0, -0.3),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: Get.back,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 20,
                                    color: Get.theme.colorScheme.secondary,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.event_detail,
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.secondary,
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Get.theme.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.bookmark_border_outlined,
                                    size: 21,
                                    color: Color(0xffEAE9FC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 56),
                              Text(
                                controller.eventData.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Get.theme.colorScheme.tertiary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 41,
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: Color(0xffEAE9FC),
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  GestureDetector(
                                    onTap: () => controller.openInGoogleMaps(),
                                    child: Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.location.value,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Get
                                                  .theme.colorScheme.tertiary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: Get.width - 97,
                                            ),
                                            child: Text(
                                              controller.displayLocation.value,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Get.theme.colorScheme
                                                    .surfaceTint,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 41,
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 20,
                                      color: Color(0xffEAE9FC),
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.eventData.date,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Get.theme.colorScheme.tertiary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        controller.eventData.time,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Get.theme.colorScheme.surfaceTint,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 41,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      controller.eventData.organizerProfile,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress != null) {
                                          return buildPlaceholder();
                                        }
                                        return child;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ashfak Sayem',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Get.theme.colorScheme.tertiary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Organizer',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Get.theme.colorScheme.surfaceTint,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Text(
                                AppLocalizations.of(context)!.ticket_type,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 24,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => ticketType(
                                    controller.eventData.ticket[index]['type'],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 15),
                                  itemCount: controller.eventData.ticket.length,
                                ),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                AppLocalizations.of(context)!.contact_organizer,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 140,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Get.theme.colorScheme.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.contact,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 140,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Get.theme.colorScheme.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.report,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Text(
                                AppLocalizations.of(context)!.about_event,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 200,
                      child: Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        child: Container(
                          width: Get.width * 0.75,
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 76,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 40,
                                      top: 0,
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://huntertalent.com.au/wp-content/uploads/2024/04/male-fashion-model-698x1024.jpg',
                                            ),
                                            fit: BoxFit.fitWidth,
                                            alignment: Alignment.topCenter,
                                          ),
                                          border: Border.all(
                                            width: 1.42,
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 20,
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://models.bestmodelsagency.com/recursos/clientes/F31110A5-6133-4F2E-96A8-927FA9485371/list.jpg?v1589811317?202410081559',
                                            ),
                                            fit: BoxFit.fitWidth,
                                            alignment: Alignment.topCenter,
                                          ),
                                          border: Border.all(
                                            width: 1.42,
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://huntertalent.com.au/wp-content/uploads/2024/04/hunter-talent-male-modelling-300x422.jpg',
                                            ),
                                            fit: BoxFit.fitWidth,
                                            alignment: Alignment.topCenter,
                                          ),
                                          border: Border.all(
                                            width: 1.42,
                                            color:
                                                Get.theme.colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => Text(
                                  controller.price.value != 0
                                      ? '${controller.price}+ ${AppLocalizations.of(context)!.going}'
                                      : '.....',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffEAE9FC),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 73,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Get.theme.colorScheme.primary,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.see_all,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xffEAE9FC),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: Get.width,
              height: 57,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 9,
              ),
              decoration: const BoxDecoration(
                color: Color(0xfffafafa),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.price}: ${controller.eventData.price}\$',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.checkout,
                      arguments: controller.eventData,
                    ),
                    child: Container(
                      width: 153,
                      height: 39,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Get.theme.colorScheme.primary,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.buy_now,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffEAE9FC),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ticketType(String text) {
    return Material(
      child: Container(
        height: 30,
        width: Get.width / controller.eventData.ticket.length - 19.3,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primary,
          border: Border.all(
            color: Get.theme.colorScheme.primary,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xffEAE9FC),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
