import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/ticket_type.dart';

part '../controllers/event_detail_controller.dart';
part '../bindings/event_detail_binding.dart';

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
                          width: Get.width,
                          height: 225,
                          alignment: Alignment.topCenter,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 13),
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
                                  child: Icon(
                                    Icons.bookmark_border_outlined,
                                    size: 21,
                                    color: Get.theme.colorScheme.tertiary,
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
                                'Khmer New Year 2025',
                                style: TextStyle(
                                  fontSize: 24,
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
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wat Phnom',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Get.theme.colorScheme.tertiary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Street 2004, midtown mall',
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
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 20,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '14 April 2025',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Get.theme.colorScheme.tertiary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Sunday 12:00AM - 12:00PM',
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
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
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
                                          fontSize: 16,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ticketType('Normal'),
                                  const SizedBox(width: 15),
                                  ticketType('Standard'),
                                  const SizedBox(width: 15),
                                  ticketType('VIP'),
                                  const SizedBox(width: 15),
                                  ticketType('VVIP'),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                              ),
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
                            children: [
                              Container(
                                width: 150,
                                color: Colors.amberAccent,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 34,
                                      height: double.infinity,
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
                                          color: Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: double.infinity * 0.5,
                                      child: Container(
                                        width: 34,
                                        height: double.infinity,
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
                                  ],
                                ),
                              )
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
                    '${AppLocalizations.of(context)!.price}: 20\$',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                  Container(
                    width: 153,
                    height: 39,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Get.theme.colorScheme.secondary,
                      ),
                      color: Get.theme.colorScheme.primary,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.buy_now,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.colorScheme.tertiary,
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
}
