part of 'edit_profile_view.dart';

class EditProfileViewController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  // var profileController = Get.find<ProfileController>();
  var mainController = Get.find<MainController>();
  late Rx<UserAccounts> userData;
  final storage = const FlutterSecureStorage();
  Rx<String> fullName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    mainController.userData.listen((data) {
      if (data != null) {
        loadProfile(data);
      }
    });

    if (mainController.userData.value != null) {
      loadProfile(mainController.userData.value!);
    }
  }

  void loadProfile(Map<String, dynamic> data) {
    userData.value = UserAccounts.fromMap(mainController.userData.value!);
    firstNameController.text = userData.value.firstName;
    lastNameController.text = userData.value.lastName;
    fullName.value = '${firstNameController.text} ${lastNameController.text}';
  }

  void saveChangeName() async {
    print('fullname ${firstNameController.text} ${lastNameController.text}');
    var id = await storage.read(key: 'id');
    var token = await storage.read(key: 'token');

    if (id == null || token == null) {
      Get.offAllNamed(Routes.login);
      return;
    }

    if ((firstNameController.text.isNotEmpty &&
            firstNameController.text != userData.value.firstName) ||
        (lastNameController.text.isNotEmpty &&
            lastNameController.text != userData.value.lastName)) {
      final dio = Dio()
        ..interceptors.add(AppLogInterceptor())
        ..options.baseUrl = 'http://10.0.2.2:8000/api'
        ..options.headers = {
          // 'Content-Type': 'application/json', 'application/json', Dio will set it correctly for FormData
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        }
        ..options.connectTimeout = const Duration(seconds: 5)
        ..options.receiveTimeout = const Duration(seconds: 5);

      var formData = FormData.fromMap({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
      });

      print('fullname ${firstNameController.text} ${lastNameController.text}');

      try {
        var response = await dio.put('/users/$id', data: formData);
        if (response.statusCode == 200) {
          var data = response.data as Map<String, dynamic>;
          if (data.isNotEmpty) {
            mainController.userData.value = data;
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
