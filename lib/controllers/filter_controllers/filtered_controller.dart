part of '../../views/filter_views/filtered_view.dart';

class FilteredController extends GetxController {
  var currentIndex = 0.obs;
  var categories = <Map<String, dynamic>>[
    {'categories': 'Filters'},
    {'categories': 'Concert'},
    {'categories': 'Phnom Penh'}
  ];
}
