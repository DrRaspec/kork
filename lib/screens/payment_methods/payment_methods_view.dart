import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/helper/card_helper.dart';
import 'package:kork/helper/payment_method.dart';
import 'package:kork/middleware/middleware.dart';
import 'package:kork/models/event_model.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kork/widget/build_placeholder.dart';

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
            Obx(
              () => controller.paymentMethod.isEmpty
                  ? buildPlaceholder(height: 40, borderRadius: 10)
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var card = PaymentMethod.fromJson(
                          controller.paymentMethod[index],
                        );
                        return Dismissible(
                          key: Key(card.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Payment Method'),
                                content: const Text(
                                  'Are you sure you want to delete this payment method?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          onDismissed: (direction) {
                            controller.deletePaymentMethod(index, card.id);
                          },
                          child: GestureDetector(
                              onTap: () => Get.back(result: true),
                              child: cardWiget(card)),
                        );
                        // return cardWiget(card);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: controller.paymentMethod.length,
                    ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: controller.reloadData,
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
}

Widget cardWiget(PaymentMethod card) {
  return GestureDetector(
    onTap: () => Get.back(),
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
            getCardType(card.cardNumber.toString()) == 'Visa'
                ? 'assets/image/svg/Visa.svg'
                : 'assets/image/svg/MasterCard.svg',
            width: 38,
          ),
          const SizedBox(width: 16),
          Text(
            maskCardNumber(card.cardNumber.toString()),
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
