part of 'event_view.dart';

class EventController extends GetxController {
  var isEvent = true.obs;
  var isLoading = true.obs;

  final eventsByCategory = RxMap<String, List<Event>>({});
  var upComingEvent = <dynamic>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await setToken();
    fetchAllCategoryEvents();
    fetchUpComingEvent();
  }

  Future<void> setToken() async {
    const storage = FlutterSecureStorage();

    var token = await storage.read(key: 'token');
    if (token == null) {
      await Get.find<AuthService>().logout();
      return;
    }
    EventApiHelper.setToken(token);
  }

  Future<void> fetchAllCategoryEvents() async {
    isLoading.value = true;

    await Future.wait(EventCategories.values
        .map((category) => fetchCategoryEvents(category.name)));

    isLoading.value = false;
  }

  Future<void> fetchCategoryEvents(String category) async {
    try {
      final response = await EventApiHelper.get(
        '/events',
        params: {
          'filter': category.toLowerCase(),
          'per_page': 5,
          // 'sort': 'desc',
        },
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final events = (response.data['data'] as List)
            .map((e) => Event.fromJson(e))
            .toList();

        eventsByCategory[category] = events;
      }
    } on DioException catch (e) {
      print('Error fetching $category events: ${e.message}');
      eventsByCategory[category] = [];
    }
  }

  List<Event> getEventsForCategory(EventCategories category) {
    return eventsByCategory[category.name] ?? [];
  }

  bool hasEventsForCategory(EventCategories category) {
    return (eventsByCategory[category.name]?.isNotEmpty ?? false);
  }

  void fetchUpComingEvent() async {
    var param = {'date': 'tomorrow'};
    try {
      var response = await EventApiHelper.get('/events', params: param);
      if (response.statusCode! < 300) {
        print('response data ${response.data}');
        print('response data type ${response.data.runtimeType}');
        upComingEvent.value = response.data['data'] as List<dynamic>;
      }
    } on DioException catch (e) {
      var response = e.response;
      print('e message ${e.message}');
      print('e error ${e.error}');
      print('status code ${response?.statusCode}');
      print('data ${response?.data}');
    }
  }
}
