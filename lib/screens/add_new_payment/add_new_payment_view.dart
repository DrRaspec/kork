import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/screens/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'add_new_payment_binding.dart';
part 'add_new_payment_controller.dart';

class AddNewPaymentView extends GetView<AddNewPaymentViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(
          AppLocalizations.of(context)!.new_card,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [],
          )),
    );
  }
}
