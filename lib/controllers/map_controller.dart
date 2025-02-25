part of '../views/sign_up_view/map_view.dart';

class MapController extends GetxController {
  var initialCameraPosition = const CameraPosition(
    target: LatLng(11.572543, 104.893275),
    zoom: 21,
  );

  GoogleMapController? googleMapController;

  Map<String, LatLng> searchCache = {};
  Timer? _debounce;

  var searchController = TextEditingController();
  var address = 'Click on map to select location'.obs;
  Timer? _timer;
  int _start = 2;
  var markers = <Marker>{}.obs;
  var isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkRequestPermission();
  }

  @override
  onClose() {
    searchController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  Future<void> _checkRequestPermission() async {
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

      if (placemarks.isNotEmpty) {
        final mark = placemarks.first;

        final List<String> addressParts = [
          mark.thoroughfare ?? '',
          mark.subThoroughfare ?? '',
          mark.locality ?? '',
          mark.administrativeArea ?? '',
          mark.country ?? '',
        ].where((element) => element.isNotEmpty).toList();

        address.value = addressParts.join(', ');
      }
    } catch (e) {
      address.value = 'Unable to fetch address';
    }
  }

  void handleTap(LatLng tappedPoint) async {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        // icon: customIcon,
        infoWindow: const InfoWindow(title: 'Selected Location'),
      ),
    );

    address.value = 'Loading...';
    delayToGetAddress(tappedPoint);
  }

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

  // Future<void> searchLocation() async {
  //   if (searchController.text.isEmpty) return;

  //   String query = searchController.text.trim().toLowerCase();

  //   // Check cache before making a request
  //   if (searchCache.containsKey(query)) {
  //     LatLng cachedLocation = searchCache[query]!;
  //     updateMapWithLocation(cachedLocation);
  //     return;
  //   }

  //   _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 800), () async {
  //     isSearching.value = true;
  //     address.value = 'Searching...';

  //     try {
  //       List<Location> locations =
  //           await locationFromAddress(searchController.text);

  //       if (locations.isNotEmpty) {
  //         Location location = locations.first;
  //         LatLng latLng = LatLng(location.latitude, location.longitude);

  //         // Cache the result
  //         searchCache[query] = latLng;

  //         updateMapWithLocation(latLng);
  //       } else {
  //         address.value = 'No results found';
  //       }
  //     } catch (e) {
  //       address.value = 'Error searching location';
  //       print('Error: $e');
  //     } finally {
  //       isSearching.value = false;
  //     }
  //   });
  // }

  void updateMapWithLocation(LatLng latLng) {
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
  }
}
