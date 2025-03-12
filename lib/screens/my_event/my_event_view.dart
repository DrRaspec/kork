import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/widget/appBarHelper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'my_event_binding.dart';
part 'my_event_controller.dart';

class MyEventView extends GetView<MyEventViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buttonBack(),
        centerTitle: true,
        title: appbarTitle(AppLocalizations.of(context)!.my_event),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [],
        ),
      ),
    );
  }

  // Widget
}
