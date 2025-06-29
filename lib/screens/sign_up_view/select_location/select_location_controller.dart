part of 'select_location_view.dart';

class SelectLocationController extends GetxController {
  final dio = Dio();
  late SharedPreferences prefs;
  final storage = const FlutterSecureStorage();
  var mapController = Get.find<MapController>();
  var firstSignUpController = Get.find<FirstSignupController>();
  var signUpController = Get.find<SignUpController>();
  var profileController = Get.find<SelectProfileController>();
  var currentLocation = const LatLng(0, 0).obs;
  var isLoading = false.obs;
  var loadingText = ''.obs;

  Timer? _timer;

  @override
  void onInit() async {
    if (!Get.isRegistered<MapController>()) {
      Get.put(MapController());
    }
    loadingText.value = AppLocalizations.of(Get.context!)?.loading ?? '';
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startLoading() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(milliseconds: 1000),
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

  // Future<void> getCurrentLocation() async {
  //   if (isLoading.value) return;
  //   isLoading.value = true;
  //   startLoading();

  //   try {
  //     // Check and request location permissions
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         Get.snackbar("Error", "Location permission denied.");
  //         isLoading.value = false;
  //         return;
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       Get.snackbar("Error", "Location permission is permanently denied.");
  //       isLoading.value = false;
  //       return;
  //     }

  //     Position position = await Geolocator.getCurrentPosition(
  //       locationSettings: const LocationSettings(
  //         accuracy: LocationAccuracy.high,
  //         distanceFilter: 10,
  //       ),
  //     );

  //     LatLng location = LatLng(position.latitude, position.longitude);
  //     currentLocation.value = location;

  //     print('current location value $currentLocation');

  //     await Future.delayed(const Duration(milliseconds: 200));

  //     if (currentLocation.value.latitude == 0 &&
  //         currentLocation.value.longitude == 0) {
  //       Get.snackbar(
  //           "Error", "Failed to retrieve your location. Please try again.");
  //       isLoading.value = false;
  //       return;
  //     } else {
  //       bool isSuccess = await saveSignUp(currentLocation.value);
  //       if (isSuccess) {
  //         if (Get.currentRoute != Routes.main) {
  //           Get.snackbar("Success", "Sign up successful");
  //           Get.offAllNamed(Routes.login);
  //         }
  //       } else {
  //         Get.snackbar("Error", "Failed to save location. Please try again.");
  //       }
  //     }
  //   } catch (error) {
  //     Get.snackbar("Error", "Failed to get location: $error");
  //     print("Failed to get location: $error");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> getCurrentLocation() async {
    if (isLoading.value) return;
    isLoading.value = true;
    startLoading();

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          "Location Disabled",
          "Please enable location services",
          duration: const Duration(seconds: 3),
          mainButton: TextButton(
            onPressed: () async {
              await Geolocator.openLocationSettings();
            },
            child:
                const Text("Settings", style: TextStyle(color: Colors.white)),
          ),
        );
        isLoading.value = false;
        return;
      }

      // Check and request permission in one step
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Permission Denied", "Location access is needed");
          isLoading.value = false;
          return;
        }
      }

      // Handle permanently denied case
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Permission Required",
          "Location permission required",
          duration: const Duration(seconds: 5),
          mainButton: TextButton(
            onPressed: () async {
              await Geolocator.openAppSettings();
            },
            child:
                const Text("Settings", style: TextStyle(color: Colors.white)),
          ),
        );
        isLoading.value = false;
        return;
      }

      // Get position with the correct parameters
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      LatLng location = LatLng(position.latitude, position.longitude);
      currentLocation.value = location;

      // Rest of your implementation...
      bool isSuccess = await saveSignUp(currentLocation.value);
      if (isSuccess) {
        if (Get.currentRoute != Routes.main) {
          Get.snackbar("Success", "Sign up successful");
          Get.offAllNamed(Routes.login);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Location error: $e");
      print("Location error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveSignUp(LatLng location) async {
    try {
      var formData = FormData();

      formData.fields.addAll([
        MapEntry('first_name', firstSignUpController.firstName.text),
        MapEntry('last_name', firstSignUpController.lastName.text),
        MapEntry('gender',
            firstSignUpController.selectedGender.value!.toLowerCase()),
        MapEntry('dob', firstSignUpController.dob.text),
        MapEntry('nationality', firstSignUpController.nationality.text),
        MapEntry('phone_number', firstSignUpController.phoneNumber.text),
        MapEntry('email', signUpController.emailController.text),
        MapEntry('password', signUpController.passwordController.text),
        MapEntry('password_confirmation',
            signUpController.conPasswordController.text),
        MapEntry('location', '${location.latitude},${location.longitude}'),
      ]);

      File profileImage = profileController.selectedImage.value ??
          await profileController.loadDefualtImage();

      formData.files.add(MapEntry(
          'profile_url',
          await MultipartFile.fromFile(profileImage.path,
              filename: profileImage.path.split('/').last)));

      dio.interceptors.add(AppLogInterceptor());
      dio.options.baseUrl = dotenv.env['API_URL']!;
      dio.options.connectTimeout = const Duration(minutes: 1);
      dio.options.receiveTimeout = const Duration(minutes: 1);

      var response = await dio.post(
        '/register',
        data: formData,
        options: Options(
          headers: {
            'contentType': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 && response.data != null) {
        var data = User.fromJson(response.data);
        if (data.token != null) {
          prefs.setBool('isLoggin', true);
          await storage.write(key: 'token', value: data.token!);
          await storage.write(key: 'id', value: data.id.toString());
          return true;
        }
      }
      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        Get.snackbar(
          'Error',
          'Connection timeout. Please check your internet connection.',
          snackPosition: SnackPosition.TOP,
        );
        print('Connection timeout. Please check your internet connection.');
      } else {
        Get.snackbar(
          'Error',
          'Request failed',
          snackPosition: SnackPosition.TOP,
        );
        print('Request failed: ${e.message}');
      }
    } catch (e) {
      print('Error saving location: $e');
    }

    return false;
  }
}
