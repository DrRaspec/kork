part of 'event_detail.dart';

class EventDetailController extends GetxController {
  late Event eventData;
  Rx<String> displayLocation = ''.obs;
  Rx<String> location = ''.obs;
  var going = 0.obs;
  late String startDate;
  late String startDay;
  var storage = const FlutterSecureStorage();
  late SharedPreferences prefs;
  var isMarked = false.obs;
  late String id;
  final List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    eventData = Get.arguments as Event;
    getLocationAddress(eventData.location);
    going.value = roundDown(56);
    startDay = weekdays[eventData.startDate.weekday - 1];
    startDate = DateFormat('dd MMM yyyy').format(eventData.startDate);
    prefs = await SharedPreferences.getInstance();
    var tempID = await storage.read(key: 'id');
    if (tempID == null) Get.find<AuthService>().logout;
    id = tempID!;
    var userId = await storage.read(key: 'id');
    isMarked.value = prefs.getBool('${userId}_${eventData.id}') ?? false;
  }

  int roundDown(int number) {
    return (number ~/ 10) * 10;
  }

  void getLocationAddress(LatLng address) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        address.latitude,
        address.longitude,
      );

      if (placemarks.isNotEmpty) {
        final mark = placemarks.last;

        final List<String> addressParts = [
          mark.name ?? '',
          mark.thoroughfare ?? '',
          mark.subThoroughfare ?? '',
          mark.subLocality ?? '',
          mark.subAdministrativeArea ?? '',
          mark.administrativeArea ?? mark.locality ?? '',
          mark.country ?? '',
        ].where((element) => element.isNotEmpty).toList();

        location.value = mark.subLocality ??
            mark.subAdministrativeArea ??
            mark.administrativeArea ??
            mark.locality ??
            mark.country ??
            'Unknown location';

        final uniqueAddressParts = addressParts.toSet().toList();
        displayLocation.value = uniqueAddressParts.join(', ');
        print("location: ${displayLocation.value}");
      } else {
        displayLocation.value = 'Address not found';
      }
    } catch (e) {
      displayLocation.value = 'Unable to fetch address';
      print('Error fetching address: $e');
    }
  }

  void openInGoogleMaps() async {
    try {
      double latitude = eventData.location.latitude;
      double longitude = eventData.location.longitude;

      final Uri googleMapsUrl = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

      final Uri googleMapsAppUrl =
          Uri.parse('comgooglemaps://?q=$latitude,$longitude');

      if (await canLaunchUrl(googleMapsAppUrl)) {
        await launchUrl(googleMapsAppUrl);
      } else if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(
          googleMapsUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'Error',
          'Could not open map application',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error opening maps: $e');
      Get.snackbar(
        'Error',
        'Could not open map application',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void markEvent() async {
    var token = await storage.read(key: 'token');
    var userId = await storage.read(key: 'id');
    var endPoint = '/users/$userId/bookmarks';

    BookmarkHelper.setToken(token!);
    String bookmarkKey = '${userId}_${eventData.id}';

    if (!isMarked.value) {
      var response = await BookmarkHelper.post(endPoint,
          data: {'event_id': eventData.id}, isFormData: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        prefs.setBool(bookmarkKey, true);
        isMarked.value = true;
      }
    } else {
      var deleteEndPoint = '$endPoint/${eventData.id}';
      var response = await BookmarkHelper.delete(deleteEndPoint);
      if (response.statusCode == 204) {
        prefs.setBool(bookmarkKey, false);
        isMarked.value = false;
      }
    }
  }

  String formatTime(String time) {
    return time.split(':').sublist(0, 2).join(':');
  }
}
