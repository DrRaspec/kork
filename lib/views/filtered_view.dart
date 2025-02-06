import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/theme/theme.dart';
import 'package:kork/views/event_view.dart';

part '../controllers/filtered_controller.dart';
part '../bindings/filtered_binding.dart';

class FilteredView extends StatelessWidget {
  const FilteredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              // const SizedBox(height: 16),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.filter,
                      style: TextStyle(
                        fontSize: 20,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Get.theme.colorScheme.tertiary,
                      size: 24,
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  return eventCard();
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
