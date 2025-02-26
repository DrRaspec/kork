part of '../views/sign_up_view/select_location_view.dart';

class SelectLocationController extends GetxController {
  var mapController = Get.find<MapController>();
  var currentLocation = const LatLng(0, 0).obs;
  var isLoading = false.obs;
  var loadingText = AppLocalizations.of(Get.context!)!.loading.obs;

  Timer? _timer;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startLoading() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        if (loadingText.value == AppLocalizations.of(Get.context!)!.loading) {
          loadingText.value = '${AppLocalizations.of(Get.context!)!.loading}.';
        } else if (loadingText.value ==
            '${AppLocalizations.of(Get.context!)!.loading}.') {
          loadingText.value = '${AppLocalizations.of(Get.context!)!.loading}..';
        } else if (loadingText.value ==
            '${AppLocalizations.of(Get.context!)!.loading}..') {
          loadingText.value =
              '${AppLocalizations.of(Get.context!)!.loading}...';
        } else {
          loadingText.value = AppLocalizations.of(Get.context!)!.loading;
        }
      },
    );
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    startLoading();

    try {
      await mapController.checkRequestPermission();
      mapController.goToCurrentLocation();

      // Wait until selectedLocation updates
      ever(
        mapController.selectedLocation,
        (LatLng location) {
          currentLocation.value = location;
          print('Updated address: ${currentLocation.value}');
          isLoading.value = false;
        },
      );
    } catch (error) {
      Get.snackbar("Error", "Failed to get location: $error");
      isLoading.value = false;
    }
  }
}
