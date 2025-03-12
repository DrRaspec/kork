part of 'map_view.dart';

class MapController extends GetxController {
  var initialCameraPosition = const CameraPosition(
    target: LatLng(11.572543, 104.893275),
    zoom: 21,
  );

  GoogleMapController? googleMapController;

  var selectedLocation = const LatLng(0, 0).obs;

  var searchController = TextEditingController();
  var address = 'Click on map to select location'.obs;
  Timer? _timer;
  int _start = 2;
  var markers = <Marker>{}.obs;
  var isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkRequestPermission();
  }

  @override
  void onClose() {
    searchController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  Future<void> checkRequestPermission() async {
    final status = await Permission.location.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      final result = await Permission.location.request();

      if (result.isPermanentlyDenied) {
        Get.defaultDialog(
          title: 'Location Permission Required',
          middleText: 'Please enable location permission is settings.',
          textConfirm: 'Open setting',
          textCancel: 'Cancel',
          onConfirm: () {
            openAppSettings();
            Get.back();
          },
        );
      }
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw ('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permission are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permission are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  void goToCurrentLocation() async {
    try {
      final position = await _getCurrentPosition();
      final LatLng latLng = LatLng(position.latitude, position.longitude);
      selectedLocation.value = latLng;

      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: latLng,
          infoWindow: const InfoWindow(title: 'My Location'),
        ),
      );

      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 18),
        ),
      );

      delayToGetAddress(latLng);
    } catch (e) {
      Get.snackbar("Error", "Error getting location: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void delayToGetAddress(LatLng location) {
    _timer?.cancel();
    _start = 2;
    _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          getLocationAddress(location);
        } else {
          _start--;
        }
      },
    );
  }

  void getLocationAddress(LatLng location) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      selectedLocation.value = location;

      if (placemarks.isNotEmpty) {
        final mark = placemarks.first;

        final List<String> addressParts = [
          mark.name ?? '', // Add this to include place names
          mark.thoroughfare ?? '',
          mark.subThoroughfare ?? '',
          mark.subLocality ?? '', // Add this for neighborhoods
          mark.subAdministrativeArea ?? '',
          mark.administrativeArea ?? mark.locality ?? '',
          mark.country ?? '',
        ].where((element) => element.isNotEmpty).toList();

        address.value = addressParts.join(', ');

        // For debugging - print all available placemark data
        print('Placemark data: ${mark.toString()}');
      }
    } catch (e) {
      address.value = 'Unable to fetch address';
      print('Error fetching address: $e');
    }
  }

  void handleTap(LatLng tappedPoint) async {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        infoWindow: const InfoWindow(title: 'Selected Location'),
      ),
    );

    address.value = 'Loading...';
    delayToGetAddress(tappedPoint);
  }

  // New method to process different types of user input
  Future<void> processUserInput(String input) async {
    if (input.isEmpty) return;

    isSearching.value = true;
    address.value = 'Processing input...';

    try {
      // Case 1: Check if input is a URL
      bool isUrl = input.startsWith('http') ||
          input.startsWith('https') ||
          input.startsWith('www.') ||
          input.contains('maps.google.com') ||
          input.contains('google.com/maps');

      // Case 2: Check if input might be direct coordinates
      RegExp latLngRegex = RegExp(r'^(-?\d+\.?\d*),\s*(-?\d+\.?\d*)$');
      var latLngMatch = latLngRegex.firstMatch(input);

      LatLng? location;

      if (isUrl) {
        // Handle URL input
        location = await extractLocationFromUrl(input);
      } else if (latLngMatch != null && latLngMatch.groupCount >= 2) {
        // Handle direct coordinates input
        double lat = double.parse(latLngMatch.group(1)!);
        double lng = double.parse(latLngMatch.group(2)!);
        location = LatLng(lat, lng);
        address.value = 'Coordinates: $lat, $lng';
      } else {
        // Case 3: Handle as place name/address
        List<Location> locations = await locationFromAddress(input);
        if (locations.isNotEmpty) {
          Location geocodedLocation = locations.first;
          location =
              LatLng(geocodedLocation.latitude, geocodedLocation.longitude);
        }
      }

      if (location != null) {
        updateMapWithLocation(location, input);
      } else {
        address.value = 'Could not find location';
      }
    } catch (e) {
      address.value = 'Error processing input';
      print('Error: $e');
    } finally {
      isSearching.value = false;
    }
  }

  Future<LatLng?> extractLocationFromUrl(String url) async {
    try {
      // Extract coordinates from Google Maps URL
      RegExp latLngRegex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
      var match = latLngRegex.firstMatch(url);

      if (match != null && match.groupCount >= 2) {
        double lat = double.parse(match.group(1)!);
        double lng = double.parse(match.group(2)!);
        return LatLng(lat, lng);
      }

      // Try to extract from query parameter (q=lat,lng)
      Uri uri = Uri.parse(url);
      String? query = uri.queryParameters['q'];

      if (query != null && query.contains(',')) {
        List<String> parts = query.split(',');
        if (parts.length >= 2) {
          try {
            double lat = double.parse(parts[0]);
            double lng = double.parse(parts[1]);
            return LatLng(lat, lng);
          } catch (e) {
            // Not valid coordinates, continue
          }
        }
      }

      // If we couldn't extract coordinates, try to geocode the URL as an address
      // This is a fallback approach if the URL doesn't contain direct coordinates
      List<Location> locations = await locationFromAddress(url);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return LatLng(location.latitude, location.longitude);
      }

      return null;
    } catch (e) {
      print('Error extracting location from URL: $e');
      return null;
    }
  }

  void updateMapWithLocation(LatLng latLng, String inputText) {
    selectedLocation.value = latLng;

    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        infoWindow: InfoWindow(title: 'Selected Location'),
      ),
    );

    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );

    // Get address for the location
    delayToGetAddress(latLng);

    // Clear search field and remove focus
    searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // Original search method - keeping for backward compatibility
  Future<void> searchLocation() async {
    if (searchController.text.isEmpty) return;

    isSearching.value = true;
    address.value = 'Searching...';

    try {
      List<Location> locations =
          await locationFromAddress(searchController.text);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng latLng = LatLng(location.latitude, location.longitude);

        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId(latLng.toString()),
            position: latLng,
            infoWindow: InfoWindow(title: searchController.text),
          ),
        );

        googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 15),
          ),
        );

        delayToGetAddress(latLng);
        searchController.clear();
        FocusManager.instance.primaryFocus?.unfocus();
      } else {
        address.value = 'No results found';
      }
    } catch (e) {
      address.value = 'Error searching location';
      print('Error: $e');
    } finally {
      isSearching.value = false;
    }
  }

  void saveLocation() {
    if (address.value != 'Error searching location' ||
        address.value != 'No results found' ||
        address.value != 'Loading...' ||
        address.value != 'Processing input...' ||
        address.value != 'Could not find location' ||
        address.value != 'Error processing input' ||
        address.value != 'Searching...') {
      Get.back();
    }
  }
}
