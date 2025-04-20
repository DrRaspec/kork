import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/utils/status.dart';
import 'package:kork/widget/event_card.dart';
import 'search_result_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResultView extends GetView<SearchResultController> {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 10) {
              Get.back();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 17),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: controller.onBack,
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
                          controller: controller.searchController,
                          textAlignVertical: TextAlignVertical.center,
                          // onTap: ()=>Get.toNamed(Routes.searchEvent,arguments: true),
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.surfaceTint,
                          ),
                          // onSubmitted: (_) => controller.resetSearch(),
                          onSubmitted: (_) {
                            if (controller.searchController.text
                                .trim()
                                .isNotEmpty) {
                              controller.resetSearch();
                            }
                          },
                          decoration: InputDecoration(
                            // enabled: false,
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
                            suffixIcon: GestureDetector(
                              onTap: () => controller.resetSearch(
                                  clearSearchText: true),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  'assets/image/svg/dangerous.svg',
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.colorScheme.surfaceTint,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
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
                    AppLocalizations.of(context)!.result,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Obx(() {
                    final status = controller.status.value;
                    final results = controller.searchResult;

                    if (status == Status.loading && results.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (status == Status.noData) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_results_found,
                          style: TextStyle(
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      );
                    } else if (status == Status.error && results.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .something_went_wrong,
                              style: TextStyle(
                                color: Get.theme.colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: controller.resetSearch,
                              child:
                                  Text(AppLocalizations.of(context)!.retry),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return _buildEventsList();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventsList() {
    return ListView.separated(
      controller: controller.scrollController,
      itemBuilder: (context, index) {
        if (index == controller.searchResult.length) {
          if (controller.status.value == Status.loadingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const SizedBox.shrink();
          }
        }

        // Display the event item
        var result = Event.fromJson(controller.searchResult[index]);
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.eventDetail, arguments: result);
          },
          child: eventCard(result),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: controller.searchResult.length +
          (controller.status.value == Status.loadingMore ? 1 : 0),
    );
  }
}
