part of 'filtered_view.dart';

class FilteredController extends GetxController {
  var argument = Get.arguments as Map<String, dynamic>;
  var status = Status.loading.obs;
  var currentIndex = 0.obs;
  var events = [].obs;
  // var page = 1;
  var categories = <Map<String, dynamic>>[
    {'categories': 'Filters'},
    {'categories': 'Concert'},
    {'categories': 'Phnom Penh'}
  ];
  // var filterController = Get.find<FilterController>();
  // late double minPrice;
  // late double maxPrice;

  void fetchData() async {
    const storage = FlutterSecureStorage();
    status.value = Status.loading;
    var token = await storage.read(key: 'token');

    if (token == null) {
      await Get.find<AuthService>().logout();
      return;
    }

    try {
      var params = {
        'filter': argument['filter'] ?? '',
        'min_price': argument['min_price'] ?? '',
        'max_price': argument['max_price'] ?? '',
        'date': argument['date'] ?? '',
      };
      var response = await EventApiHelper.get('/events', params: params);
      if (response.statusCode == 200) {
        events.value = response.data['data'];
      }
    } on DioException catch (e) {
      print(e.response?.data);
      status.value = Status.error;
    }
  }
}
