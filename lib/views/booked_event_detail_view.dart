import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/build_placeholder.dart';

part '../controllers/booked_event_detail_controller.dart';
part '../bindings/booked_event_detail_binding.dart';

class BookedEventDetailView extends GetView<BookedEventDetailController> {
  const BookedEventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 225,
                    color: Get.theme.colorScheme.tertiary,
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Image.network(
                          'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: Get.height,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(
                              Icons.error,
                              size: 20,
                              color: Get.theme.colorScheme.secondary,
                            ),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return buildPlaceholder();
                          },
                        ),
                        Padding(
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
                                AppLocalizations.of(context)!.book_ticket,
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
                      ],
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
                              child: const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Color(0xffEAE9FC),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Get.theme.colorScheme.surfaceTint,
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
                              child: const Icon(
                                Icons.calendar_month_outlined,
                                size: 20,
                                color: Color(0xffEAE9FC),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Get.theme.colorScheme.surfaceTint,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Get.theme.colorScheme.surfaceTint,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Get.theme.colorScheme.tertiary,
                                    border: Border.all(
                                      width: 1.42,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                  child: Image.network(
                                    'https://huntertalent.com.au/wp-content/uploads/2024/04/male-fashion-model-698x1024.jpg',
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Get.theme.colorScheme.secondary,
                                        size: 15,
                                      ),
                                    ),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return buildPlaceholder();
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 20,
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Get.theme.colorScheme.tertiary,
                                    border: Border.all(
                                      width: 1.42,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                  child: Image.network(
                                    'https://models.bestmodelsagency.com/recursos/clientes/F31110A5-6133-4F2E-96A8-927FA9485371/list.jpg?v1589811317?202410081559',
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Get.theme.colorScheme.secondary,
                                        size: 15,
                                      ),
                                    ),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return buildPlaceholder();
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Get.theme.colorScheme.tertiary,
                                    border: Border.all(
                                      width: 1.42,
                                      color: Get.theme.colorScheme.tertiary,
                                    ),
                                  ),
                                  child: Image.network(
                                    'https://huntertalent.com.au/wp-content/uploads/2024/04/hunter-talent-male-modelling-300x422.jpg',
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Get.theme.colorScheme.secondary,
                                        size: 15,
                                      ),
                                    ),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return buildPlaceholder();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '+20 ${AppLocalizations.of(context)!.going}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xffEAE9FC),
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
    );
  }

  Widget ticketType(String text) {
    return Expanded(
      child: Material(
        child: Obx(
          () => InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              controller.selectedType.value = text;
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primary,
                border: Border.all(
                  width: 2,
                  color: controller.selectedType.value == text
                      ? Get.theme.colorScheme.tertiary
                      : Get.theme.colorScheme.primary,
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xffEAE9FC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
