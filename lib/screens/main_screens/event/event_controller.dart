part of 'event_view.dart';

class EventController extends GetxController {
  var isEvent = true.obs;
  var isLoading = true.obs;

  final eventsByCategory = RxMap<String, List<Event>>({});

  @override
  void onInit() {
    super.onInit();
    fetchAllCategoryEvents();
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
}
