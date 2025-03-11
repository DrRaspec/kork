import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/screens/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'apply_coupon_binding.dart';
part 'apply_coupon_controller.dart';

class ApplyCouponView extends GetView<ApplyCouponViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.apply_voucher,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Obx(
              () => SizedBox(
                height: 40,
                child: TextField(
                  controller: controller.searchCouponController,
                  textAlignVertical: TextAlignVertical.center,
                  style:
                      const TextStyle(color: Color(0xffEAE9FC), fontSize: 12),
                  onChanged: (value) {
                    controller.searchText.value = value;
                    if (value.isEmpty) {
                      controller.validCoupon.value = {};
                    }
                  },
                  focusNode: controller.focusNode,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Get.theme.colorScheme.secondary,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: SvgPicture.asset(
                        'assets/image/svg/search-normal.svg',
                        colorFilter: ColorFilter.mode(
                          Get.theme.colorScheme.surfaceTint,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    suffixIcon: controller
                            .searchCouponController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              controller.searchCouponController.clear();
                              controller.validCoupon.value = {};
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              child: SvgPicture.asset(
                                'assets/image/svg/dangerous.svg',
                                colorFilter: ColorFilter.mode(
                                  Get.theme.colorScheme.surfaceTint,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    hintText: AppLocalizations.of(context)!.search_coupon,
                    hintStyle: TextStyle(
                      color: Get.theme.colorScheme.surfaceTint,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.voucher,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => controller.validCoupon.isNotEmpty
                  ? GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          spacing: 16,
                          children: [
                            SvgPicture.asset(
                              'assets/image/svg/discount-circle.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Get.theme.colorScheme.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.validCoupon['coupon'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffEAE9FC),
                                ),
                              ),
                            ),
                            Text(
                              '${controller.validCoupon['discount']}%',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xffEAE9FC),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
