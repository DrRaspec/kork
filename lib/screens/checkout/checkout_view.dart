import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/models/event_detail_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/widget/build_placeholder.dart';
import 'package:kork/screens/widget/appBarHelper.dart';
import 'package:kork/screens/widget/custom_expansion.dart';

part 'checkout_binding.dart';
part 'checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.check_out,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 10) {
            Get.back();
          }
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.quantity,
                          style: TextStyle(
                            fontSize: 16,
                            color: Get.theme.colorScheme.tertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        // height: 386,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ticketCard(index),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: controller.data.ticket.length,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.payment_detail,
                          style: TextStyle(
                            fontSize: 16,
                            color: Get.theme.colorScheme.tertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.paymentMethod),
                        child: Container(
                          height: 42,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 16,
                            children: [
                              SvgPicture.asset(
                                'assets/image/svg/discount-shape.svg',
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Get.theme.colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .select_payment_method,
                                  style: const TextStyle(
                                    color: Color(0xffEAE9FC),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 16,
                                color: Color(0xffEAE9FC),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 42,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 16,
                          children: [
                            SvgPicture.asset(
                              'assets/image/svg/card.svg',
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Get.theme.colorScheme.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .select_payment_method,
                                style: const TextStyle(
                                  color: Color(0xffEAE9FC),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 16,
                              color: Color(0xffEAE9FC),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customExpansion(),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Get.theme.bottomNavigationBarTheme.backgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.total}: \$${controller.total.value}',
                            style: TextStyle(
                              color: Get.theme.colorScheme.tertiary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 152,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Get.theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.confirm_pay,
                                style: const TextStyle(
                                  color: Color(0xffEAE9FC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget ticketCard(int index) {
    return Container(
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.theme.colorScheme.secondary,
      ),
      child: Row(
        spacing: 10,
        children: [
          Container(
            height: Get.height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffE5D9F2),
            ),
            child: Image.network(
              controller.data.image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return buildPlaceholder();
                }
                return child;
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.data.title} | ${controller.data.ticket[index]['type']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xffEAE9FC),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(controller.data.ticket[index]['price'] as num).toStringAsFixed(2)}\$',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xffEAE9FC),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.decreaseQuantity(index),
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.remove,
                            color: Color(0xffEAE9FC),
                            size: 11,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => Text(
                        controller.ticketQuantity[index].toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffEAE9FC),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => controller.increaseQuantity(index),
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Color(0xffEAE9FC),
                            size: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
