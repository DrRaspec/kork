import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'edit_profile_binding.dart';
part 'edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.edit_profile),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.save,
              style: TextStyle(
                fontSize: 14,
                color: Get.theme.colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Get.theme.colorScheme.tertiary,
                width: 2,
                ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/image/cambodia.png',
                width: 116,
                height: 116,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
