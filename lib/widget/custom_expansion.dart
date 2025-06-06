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
                    Obx(
                      () => _buildDetailRow(
                        context,
                        AppLocalizations.of(context)!.voucher,
                        '${controller.discountPrice.toStringAsFixed(2)}\$',
                      ),
                    ),
                    Divider(color: Get.theme.colorScheme.surfaceTint),
                    _buildDetailRow(
                      context,
                      AppLocalizations.of(context)!.fee,
                      '${controller.feePercent.toString()}%',
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
                      style: TextStyle(
                        fontSize: 12,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      controller.isExpand.value
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up_outlined,
                      size: 18,
                      color: Get.theme.colorScheme.tertiary,
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
        style: TextStyle(
          color: Get.theme.colorScheme.surfaceTint,
          fontSize: 10,
        ),
      ),
      const Spacer(),
      Text(
        value,
        style: TextStyle(
          color: Get.theme.colorScheme.surfaceTint,
          fontSize: 10,
        ),
      ),
    ],
  );
}
