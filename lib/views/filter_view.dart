import 'package:flutter/material.dart';
import 'package:get/get.dart';

part '../controllers/filter_controller.dart';
part '../bindings/filter_binding.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter',
          style: TextStyle(
            fontSize: 20,
            color: Get.theme.colorScheme.tertiary,
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Get.theme.colorScheme.tertiary,
            size: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            Text(''),
          ],
        ),
      ),
    );
  }
}
