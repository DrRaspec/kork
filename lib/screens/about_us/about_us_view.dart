import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'about_us_binding.dart';
part 'about_us_controller.dart';

class AboutUsView extends GetView<AboutUsViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.about_us),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.about_kork,
              style: TextStyle(
                fontSize: 12,
                color: Get.theme.colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text()
          ],
        ),
      ),
    );
  }
}
