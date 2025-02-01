import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kork/views/home_view.dart';

part '../bindings/main_binding.dart';
part '../controllers/main_controller.dart';
part '../widget/my_bottom_navigation.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: IndexedStack(
        children: controller.screen,
      ),
      bottomNavigationBar: myBottomNavigation(),
    );
  }
}
