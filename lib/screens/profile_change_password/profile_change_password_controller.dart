part of 'profile_change_password_view.dart';

class ProfileChangePasswordViewController extends GetxController
    with GetTickerProviderStateMixin {
  var editProfileController = Get.find<EditProfileViewController>();
  late RxString fullName;
  Rx<String> languageCode =
      Get.find<LanguageController>().currentLocale.languageCode.obs;
  final storage = const FlutterSecureStorage();

  var obsecureCurrentPassword = true.obs;
  var obsecureNewPassword = true.obs;
  var obsecureConfirmPassword = true.obs;
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();

  var currentPasswordError = ''.obs;
  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;

  late FocusNode currentPasswordFocus;
  late FocusNode newPasswordFocus;
  late FocusNode confirmPasswordFocus;

  late AnimationController currentPasswordShakeController;
  late AnimationController newPasswordShakeController;
  late AnimationController confirmPasswordShakeController;

  late Animation<double> currentPasswordShakeAnimation;
  late Animation<double> newPasswordShakeAnimation;
  late Animation<double> confirmPasswordShakeAnimation;

  @override
  void onInit() {
    super.onInit();
    fullName.value = editProfileController.fullName.value;
    currentPasswordFocus = FocusNode();
    newPasswordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();

    currentPasswordShakeController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    newPasswordShakeController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    confirmPasswordShakeController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    currentPasswordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(currentPasswordShakeController);

    newPasswordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(newPasswordShakeController);

    confirmPasswordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(confirmPasswordShakeController);
  }

  void triggercurrentPasswordShake() {
    currentPasswordShakeController.forward(from: 0);
  }

  void trigglePasswordShake() {
    newPasswordShakeController.forward(from: 0);
  }

  void triggleConfirmPasswordShake() {
    confirmPasswordShakeController.forward(from: 0);
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    conPasswordController.dispose();
    currentPasswordShakeController.dispose();
    newPasswordShakeController.dispose();
    confirmPasswordShakeController.dispose();
    currentPasswordFocus.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }

  Future<void> validateInput() async {
    currentPasswordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';
    bool hasError = false;

    hasError = await updateUser();
    if (newPasswordController.text.isEmpty) {
      newPasswordError.value =
          '${AppLocalizations.of(Get.context!)!.password} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      trigglePasswordShake();
      hasError = true;
    } else if (newPasswordController.text.length < 8 ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(newPasswordController.text)) {
      newPasswordError.value =
          AppLocalizations.of(Get.context!)!.password_quide;
      trigglePasswordShake();
      hasError = true;
    }

    if (conPasswordController.text.isEmpty) {
      confirmPasswordError.value =
          '${AppLocalizations.of(Get.context!)!.confirm_password} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      triggleConfirmPasswordShake();
      hasError = true;
    } else if (conPasswordController.text != newPasswordController.text) {
      confirmPasswordError.value =
          AppLocalizations.of(Get.context!)!.password_not_match;
      trigglePasswordShake();
      hasError = true;
    }

    if (hasError) {
      Future.delayed(
        Duration.zero,
        () {
          if (currentPasswordError.isNotEmpty) {
            currentPasswordFocus.requestFocus();
          } else if (newPasswordError.isNotEmpty) {
            newPasswordFocus.requestFocus();
          } else if (confirmPasswordError.isNotEmpty) {
            confirmPasswordFocus.requestFocus();
          }
        },
      );
    }
  }

  Future<bool> updateUser() async {
    var id = await storage.read(key: 'id');
    var token = await storage.read(key: 'token');

    if (id == null || token == null) {
      Get.offAllNamed(Routes.login);
      return false;
    }

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
      'current_password': currentPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': conPasswordController.text,
    });

    try {
      var response = await dio.post('/password-change', data: formData);
      if (response.statusCode == 200) {
        var data = response.data as Map<String, dynamic>;
        if (data.containsKey('errors')) {
          currentPasswordError.value =
              AppLocalizations.of(Get.context!)!.incorrect_passowrd;
          triggercurrentPasswordShake();
          return false;
        }
      }
    } on DioException catch (e) {
      print(e.message);
      if (e.response != null) {
        var response = e.response;
        var error = response!.data['errors'] as Map;
        if (response.statusCode == 422 &&
            error.containsKey('current_password')) {
          currentPasswordError.value =
              AppLocalizations.of(Get.context!)!.incorrect_passowrd;
        }
      }
      return true;
    }
    return true;
  }

  void onTap() async {
    await validateInput();
    if (currentPasswordError.isEmpty &&
        newPasswordError.isEmpty &&
        confirmPasswordError.isEmpty) {
      Get.snackbar('Success', 'Password Change Successfully');
    }
  }
}
