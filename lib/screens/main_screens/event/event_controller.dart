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
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      if (token == null || token.isEmpty) {
        Get.find<AuthService>().logout;
        return;
      }
      EventApiHelper.setToken(token);
      var response = await EventApiHelper.get('/events', params: param);
      if (response.statusCode != null && response.statusCode! < 300) {
        if (response.data != null) {
          // print('event screen response data ${response.data}');
          // print('response data type ${response.data.runtimeType}');
          upComingEvent.value = response.data['data'] as List;
          print('upcoming event ${response.data['data']}');
        }
        // else {
        //   Get.snackbar('fail', 'Unexpected data format received');
        //   logError('Unexpected data format', response.data);
        // }
      } else {
        Get.snackbar('Error', 'Failed to load events: ${response.statusCode}');
        logError('HTTP Error', {
          'status': response.statusCode,
          'data': response.data,
        });
      }
    } on DioException catch (e) {
      final errorMessage = _getDioErrorMessage(e);
      Get.snackbar('Error', errorMessage);
      logError('Dio Exception', {
        'message': e.message,
        'error': e.error,
        'statusCode': e.response?.statusCode,
        'data': e.response?.data,
      });
    } catch (e) {
      Get.snackbar('Error', 'Unexpected error occurred');
      logError('Unexpected Error', e.toString());
    }
  }

  String _getDioErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection. Please try again when you\'re online.';
    } else if (e.response != null) {
      switch (e.response!.statusCode) {
        case 401:
          // Automatically logout on unauthorized
          Get.find<AuthService>().logout();
          return 'Session expired. Please login again.';
        case 403:
          return 'You don\'t have permission to access this resource.';
        case 404:
          return 'The requested resource was not found.';
        case 500:
          return 'Server error. Please try again later.';
        default:
          return 'Error: ${e.response!.statusCode}';
      }
    }
    return 'Network error occurred. Please try again.';
  }

  void logError(String type, dynamic detail) {
    print('ERROR [$type]: $detail');
  }

  void onPopResult() {
    var mainController = Get.find<MainController>();
    mainController.changeTabIndex(0);
  }
}
