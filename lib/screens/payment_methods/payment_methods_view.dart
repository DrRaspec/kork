import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/helper/card_helper.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'payment_methods_binding.dart';
part 'payment_methods_controller.dart';

class PaymentMethodsView extends GetView<PaymentMethodsViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.payment_method),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.online_payment_option,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) => cardWiget('4539148803436467'),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 2,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.addNewPayment),
              child: Container(
                height: 40,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.theme.colorScheme.secondary,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 24,
                      color: Color(0xffEAE9FC),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      AppLocalizations.of(context)!.add_new_payment,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffEAE9FC),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cardWiget(String cardNumber) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.theme.colorScheme.secondary,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              getCardType(cardNumber) == 'Visa'
                  ? 'assets/image/svg/Visa.svg'
                  : 'assets/image/svg/MasterCard.svg',
              width: 38,
            ),
            const SizedBox(width: 16),
            Text(
              maskCardNumber(cardNumber),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xffEAE9FC),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
