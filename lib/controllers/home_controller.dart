part of '../views/home_view.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  var mainControler = Get.find<MainController>();
  var dummyData = <Map<String, dynamic>>[
    {
      'date': '10 June',
      'title': 'nika title',
      'location': 'Wat Phnom',
      'time': '10:00AM - 11:30PM'
    },
    {
      'date': '10 June',
      'title': 'nika title',
      'location': 'Wat Phnom',
      'time': '10:00AM - 11:30PM'
    },
    {
      'date': '10 June',
      'title': 'nika title',
      'location': 'Wat Phnom',
      'time': '10:00AM - 11:30PM'
    },
    {
      'date': '10 June',
      'title': 'nika title',
      'location': 'Wat Phnom',
      'time': '10:00AM - 11:30PM'
    },
  ];
}
