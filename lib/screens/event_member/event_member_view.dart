import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'event_member_binding.dart';
part 'event_member_controller.dart';

class EventMemberView extends GetView<EventMemberController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Get.back,
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.people_going,
          style: TextStyle(
            fontSize: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.all_member,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://hips.hearstapps.com/hmg-prod/images/wiz_khalifa_photo_by_phil_blatch_newspix_getty_461033569.jpg?crop=1xw:1.0xh;center,top&resize=640:*',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ma Nika',
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            'ma.nika@example.com',
                            style: TextStyle(
                              fontSize: 10,
                              color: Get.theme.colorScheme.surfaceTint,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
