part of 'event_detail.dart';

class EventDetailController extends GetxController {
  late EventDetailModel eventData;
  Rx<String> displayLocation = ''.obs;
  Rx<String> location = ''.obs;
  var price = 0.obs;

  @override
  void onInit() {
    super.onInit();
    eventData = Get.arguments as EventDetailModel;
    getLocationAddress(eventData.street);
    price.value = roundDown(eventData.member);
  }

  int roundDown(int number) {
    return (number ~/ 10) * 10;
  }

  void getLocationAddress(String street) async {
    try {
      List<String> parts = street.split(',');
      double latitude = double.parse(parts[0].trim());
      double longitude = double.parse(parts[1].trim());

      final placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
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
      List<String> parts = eventData.street.split(',');
      double latitude = double.parse(parts[0].trim());
      double longitude = double.parse(parts[1].trim());

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
}
