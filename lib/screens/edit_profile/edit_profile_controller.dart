part of 'edit_profile_view.dart';

class EditProfileViewController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mainController = Get.find<MainController>();
  Rx<User?> userData = Rx<User?>(null);
  final storage = const FlutterSecureStorage();
  Rx<String> fullName = ''.obs;
  final ImagePicker picker = ImagePicker();
  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    ever(mainController.userDataReady, (isReady) {
      if (isReady && mainController.userData.value != null) {
        loadProfile();
      }
    });

    if (mainController.userDataReady.value &&
        mainController.userData.value != null) {
      loadProfile();
    }
  }

  void loadProfile() {
    if (mainController.userData.value != null) {
      final userMap = mainController.userData.value;

      if (userMap != null) {
        userData.value = userData.value = User.fromJson(userMap);

        firstNameController.text = userData.value!.firstName;
        lastNameController.text = userData.value!.lastName;
        fullName.value =
            '${firstNameController.text} ${lastNameController.text}';
      }
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void saveChangeName() async {
    var id = await storage.read(key: 'id');
    var token = await storage.read(key: 'token');

    if (id == null || token == null) {
      Get.offAllNamed(Routes.login);
      return;
    }

    final isFirstNameChanged = firstNameController.text.isNotEmpty &&
        firstNameController.text != userData.value!.firstName;

    final isLastNameChanged = lastNameController.text.isNotEmpty &&
        lastNameController.text != userData.value!.lastName;

    final isImageSelected = selectedImage.value != null;

    // Only continue if something actually changed
    if (isFirstNameChanged || isLastNameChanged || isImageSelected) {
      final dio = Dio()
        ..interceptors.add(AppLogInterceptor())
        ..options.baseUrl = dotenv.env['API_URL']!
        ..options.headers = {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        }
        ..options.connectTimeout = const Duration(minutes: 1)
        ..options.receiveTimeout = const Duration(minutes: 1);

      var formData = FormData.fromMap({
        '_method': 'PUT',
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
      });

      if (isImageSelected) {
        formData.files.add(MapEntry(
          'profile_url',
          await MultipartFile.fromFile(
            selectedImage.value!.path,
            filename: selectedImage.value!.path.split('/').last,
          ),
        ));
      }

      try {
        var response = await dio.post('/users/$id', data: formData);
        if (response.statusCode == 200) {
          var data = response.data as Map<String, dynamic>;
          if (data.isNotEmpty) {
            mainController.userData.value = data;
            userData.value = User.fromJson(data);
            firstNameController.text = userData.value!.firstName;
            lastNameController.text = userData.value!.lastName;
            fullName.value =
                '${userData.value!.firstName} ${userData.value!.lastName}';
            mainController.userData.value = userData.toJson();
            mainController.update();

            Get.snackbar('Success', 'Update Change Successfully');
          }
        }
      } on DioException catch (e) {
        print('Error during profile update: ${e.message}');
        if (e.response != null) {
          print('Status code: ${e.response!.statusCode}');
          print('Response: ${e.response!.data}');
        }
      }
    } else {
      Get.snackbar('No changes', 'Nothing to update.');
    }
  }
}
