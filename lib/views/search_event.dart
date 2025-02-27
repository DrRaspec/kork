import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part '../bindings/search_event_binding.dart';
part '../controllers/search_event_controller.dart';

class SearchEvent extends GetView<SearchEventController> {
  const SearchEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 10) {
                Get.back();
              }
            },
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(AppLocalizations.of(context)!.recent)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
