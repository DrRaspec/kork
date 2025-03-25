part of 'edit_profile_view.dart';

class EditProfileViewController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mainController = Get.find<MainController>();
  Rx<UserAccounts?> userData = Rx<UserAccounts?>(null);
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
        userData.value = userData.value = UserAccounts.fromMap(userMap);

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

    if ((firstNameController.text.isNotEmpty &&
            firstNameController.text != userData.value!.firstName) ||
        (lastNameController.text.isNotEmpty &&
            lastNameController.text != userData.value!.lastName) ||
        selectedImage.value != null) {
      File profileImage = selectedImage.value!;
      final dio = Dio()
        ..interceptors.add(AppLogInterceptor())
        ..options.baseUrl = 'http://10.0.2.2:8000/api'
        ..options.headers = {
          // 'Content-Type': 'application/json', 'application/json', Dio will set it correctly for FormData
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        }
        ..options.connectTimeout = const Duration(seconds: 15)
        ..options.receiveTimeout = const Duration(seconds: 15);

      var formData = FormData.fromMap({
        '_method': 'PUT',
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
      });

      formData.files.add(MapEntry(
          'profile_url',
          await MultipartFile.fromFile(profileImage.path,
              filename: profileImage.path.split('/').last)));

      try {
        var response = await dio.post('/users/$id', data: formData);
        if (response.statusCode == 200) {
          var data = response.data as Map<String, dynamic>;
          if (data.isNotEmpty) {
            mainController.userData.value = data;

            userData.value = UserAccounts.fromMap(data);
            firstNameController.text = userData.value!.firstName;
            lastNameController.text = userData.value!.lastName;
            print('edit profile user data ${json.encode(userData.toJson())}');
            mainController.userData.value = response.data;
            Get.snackbar('Success', 'Update Change Successfully');
          }
        }
      } on DioException catch (e) {
        print(e.message);
        if (e.response != null) {
          print(e.response!.statusCode);
        }
      }
    }
  }
}
