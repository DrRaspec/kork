part of '../views/main_view.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var screen = [
    const HomeView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
  ];
}
