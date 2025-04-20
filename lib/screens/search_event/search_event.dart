import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/event_recent_search.dart';

part 'search_event_binding.dart';

part 'search_event_controller.dart';

class SearchEvent extends GetView<SearchEventController> {
  const SearchEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 10) {
                  Get.back();
                }
              },
              child: const SizedBox.expand(),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 17),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Get.theme.colorScheme.tertiary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            controller: controller.searchEvent,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.surfaceTint,
                            ),
                            onSubmitted: controller.onSubmit,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                size: 16,
                                color: Get.theme.colorScheme.surfaceTint,
                              ),
                              hintText:
                                  AppLocalizations.of(context)!.search_event,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.surfaceTint,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 11,
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Get.theme.colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.recent,
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => controller.recentSearch.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.no_recent_searches,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final search = controller.recentSearch[index];
                              return GestureDetector(
                                onTap: () => controller.onRecentTap(search),
                                child: eventRecentSearch(search),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemCount: controller.recentSearch.length,
                          ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: eventRecentSearch(),
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
