import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget getFreeVoucher() {
  final context = Get.context;
  if (context == null) {
    return const SizedBox();
  }
  return Container(
    height: 107,
    width: double.infinity,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: const DecorationImage(
        image: AssetImage(
          'assets/image/voucher.png',
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${AppLocalizations.of(context)!.apply_code_to_get} ',
                style: TextStyle(
                  fontSize: Get.width <= 360 ? 14 : 16,
                  color: const Color(0xffEAE9FC),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${AppLocalizations.of(context)!.free_voucher} ',
                style: TextStyle(
                  fontSize: Get.width <= 360 ? 14 : 16,
                  color: Get.theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            AppLocalizations.of(context)!.get_20,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xffEAE9FC).withOpacity(.5),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 106,
              height: 21,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [
                    Get.theme.colorScheme.primary,
                    Get.theme.colorScheme.onInverseSurface,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.enter_code,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xffEAE9FC),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
