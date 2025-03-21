import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/main_screens/event/event_view.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'bookmark_binding.dart';
part 'bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.bookmark,
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.searchEvent),
            child: Icon(
              Icons.search,
              color: Get.theme.colorScheme.tertiary,
              size: 24,
            ),
          ),
          const SizedBox(width: 22),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.filter);
            },
            child: Icon(
              Icons.filter_list,
              color: Get.theme.colorScheme.tertiary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {},
              child: eventCard(),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: 3,
          ),
        ),
      ),
    );
  }
}
