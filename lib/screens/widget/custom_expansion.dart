import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/screens/checkout/checkout_view.dart';

Widget customExpansion() {
  var context = Get.context;
  if (context == null) return const SizedBox.shrink();
  var controller = Get.find<CheckoutController>();

  return Container(
    color: Get.theme.colorScheme.secondary,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Obx(
          () {
            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(
                  begin: 0.0, end: controller.isExpand.value ? 1.0 : 0.0),
              builder: (context, value, child) {
                return ClipRect(
                  child: Align(
                    heightFactor: value,
                    alignment: Alignment.bottomCenter,
                    child: child,
                  ),
                );
              },
              child: Container(
                color: Get.theme.colorScheme.secondary,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDetailRow(
                      context,
                      AppLocalizations.of(context)!.voucher,
                      '${controller.discount.toStringAsFixed(2)}\$',
                    ),
                    const Divider(color: Color(0x80EAE9FC)),
                    _buildDetailRow(
                      context,
                      AppLocalizations.of(context)!.fee,
                      '${controller.discount.toStringAsFixed(2)}\$',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () => controller.toggleExpand(),
          child: Container(
            width: double.infinity,
            color: Get.theme.colorScheme.secondary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.isExpand.value
                          ? AppLocalizations.of(context)!.show_less
                          : AppLocalizations.of(context)!.show_detail,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      controller.isExpand.value
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up_outlined,
                      size: 18,
                      color: const Color(0xffEAE9FC),
                    ),
                  ],
                )),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDetailRow(BuildContext context, String label, String value) {
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Color(0x80EAE9FC),
          fontSize: 10,
        ),
      ),
      const Spacer(),
      Text(
        value,
        style: const TextStyle(
          color: Color(0x80EAE9FC),
          fontSize: 10,
        ),
      ),
    ],
  );
}
