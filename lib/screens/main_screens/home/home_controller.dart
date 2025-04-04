part of 'home_view.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  var mainControler = Get.find<MainController>();
  var eventController = Get.find<EventController>();
  Rx<User?> userData = Rx<User?>(null);
  final categories = RxMap<String, List<Event>>({});
  late Timer timer;
  var dotCount = 1.obs;
  var location = ''.obs;
  var isValueAdded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    print('home controller init');
    ever(mainControler.userDataReady, (isReady) {
      if (isReady && mainControler.userData.value != null) {
        processUserData();
        isValueAdded.value = true;
      }
    });

    if (mainControler.userDataReady.value &&
        mainControler.userData.value != null) {
      processUserData();
      isValueAdded.value = true;
    }

    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      dotCount.value = (dotCount % 3) + 1 as int;
    });
    await setToken();
    fetchUpComingData();
    fetchShowingData();
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

  void processUserData() {
    try {
      final responseData = mainControler.userData.value;

      if (responseData != null) {
        userData.value = User.fromJson(responseData);
        convertLocation();

        print('Successfully processed user data: ${userData.value?.id}');
      } else {
        print('No user data found in the response');
      }
    } catch (e) {
      print('Error processing user data: $e');
      print('Raw user data: ${mainControler.userData.value}');
    }
  }

  void convertLocation() async {
    if (userData.value == null || userData.value!.location.isEmpty) {
      location.value = 'unknown';
      return;
    }
    var stringLatlng = userData.value!.location.obs;
    print('latlong $stringLatlng');
    List<String> split = stringLatlng.value.split(',');

    if (split.length < 2) {
      location.value = 'unknown';
      return;
    }

    try {
      double lat = double.parse(split[0].trim());
      double lng = double.parse(split[1].trim());

      var latlng = LatLng(lat, lng);
      var placemark =
          await placemarkFromCoordinates(latlng.latitude, latlng.longitude);

      if (placemark.isNotEmpty) {
        var mark = placemark.first;
        location.value = mark.administrativeArea ?? mark.locality ?? 'unknown';
      }
    } catch (e) {
      print("Error converting location: $e");
      location.value = 'unknown';
    }
  }

  void categoryScreen() {
    eventController.isEvent.value = false;
    mainControler.currentIndex.value = 1;
  }

  void updateScreen(int pageNumber) {
    mainControler.currentIndex.value = pageNumber;
  }

  Future<void> fetchUpComingData() async {
    try {
      final response = await EventApiHelper.get(
        '/events',
        params: {
          'date': 'tomorrow',
          'per_page': 5,
          // 'sort': 'desc',
        },
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final events = (response.data['data'] as List)
            .map((e) => Event.fromJson(e))
            .toList();

        categories['upcoming'] = events;
        print('load home tomorrow success $categories');
      }
    } on DioException catch (e) {
      print('Error fetching up coming events: ${e.message}');
      categories['upcoming'] = [];
    }
  }

  Future<void> fetchShowingData() async {
    try {
      final response = await EventApiHelper.get(
        '/events',
        params: {
          'date': 'today',
          'per_page': 5,
          // 'sort': 'desc',
        },
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final events = (response.data['data'] as List)
            .map((e) => Event.fromJson(e))
            .toList();

        categories['showing'] = events;
        print('load home today success $categories');
      }
    } on DioException catch (e) {
      print('Error fetching up coming events: ${e.message}');
      categories['showing'] = [];
    }
  }
}
