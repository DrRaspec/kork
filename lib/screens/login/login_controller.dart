part of 'login_view.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  final dio = Dio();
  late SharedPreferences prefs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  var emailError = ''.obs;
  var passwordError = ''.obs;

  late AnimationController emailShakeController;
  late AnimationController passwordShakeController;
  late Animation<double> emailShakeAnimation;
  late Animation<double> passwordShakeAnimation;

  var passwordObsecure = true.obs;

  @override
  void onInit() async {
    super.onInit();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    emailShakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    emailShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(emailShakeController);

    passwordShakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    passwordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(passwordShakeController);

    prefs = await SharedPreferences.getInstance();
  }

// In GetX, onReady() is a lifecycle method in GetxController that gets called after the widget has been rendered on the screen.
  // @override
  // void onReady() async {
  //   super.onReady();
  // }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailShakeController.dispose();
    passwordShakeController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  void triggerEmailShake() {
    emailShakeController.forward(from: 0);
  }

  void triggerPasswordShake() {
    passwordShakeController.forward(from: 0);
  }

  Future<void> validateInputs() async {
    bool hasError = false;

    emailError.value = '';
    passwordError.value = '';

    if (emailController.text.trim().isEmpty) {
      emailError.value =
          '${AppLocalizations.of(Get.context!)!.email_username} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      triggerEmailShake();
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(emailController.text.trim())) {
      emailError.value = AppLocalizations.of(Get.context!)!.invalid_email;
      triggerEmailShake();
      hasError = true;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value =
          '${AppLocalizations.of(Get.context!)!.password} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      triggerPasswordShake();
    }

    hasError = await checkValidEmail();

    if (hasError) {
      Future.delayed(
        Duration.zero,
        () {
          if (emailError.isEmpty && passwordError.isNotEmpty) {
            passwordFocusNode.requestFocus();
          } else if (emailError.isNotEmpty) {
            emailFocusNode.requestFocus();
          }
        },
      );
      return;
    }
  }

  Future<bool> checkValidEmail() async {
    try {
      dio.interceptors.add(AppLogInterceptor());
      dio.options.connectTimeout = const Duration(seconds: 15);
      dio.options.receiveTimeout = const Duration(seconds: 15);
      var response = await dio.post(
        'http://10.0.2.2:8000/api/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          contentType: 'application/json',
        ),
      );
      var result = response.data as Map<String, dynamic>;
      print('response data $result');
      await storage.write(key: 'id', value: result['id'].toString());
      await storage.write(key: 'token', value: result['token']);
      return false;
    } on DioException catch (e) {
      var response = e.response;
      // if (response != null && response.data is Map<String, dynamic>) {
      if (response != null && response.statusCode == 422) {
        var result = response.data as Map<String, dynamic>;
        if (result.containsKey('error')) {
          passwordError.value =
              AppLocalizations.of(Get.context!)!.incorrect_email_password;
          emailError.value =
              AppLocalizations.of(Get.context!)!.incorrect_email_password;
        }
      } else {
        printError(info: e.toString());
      }
    }
    return true;
  }

  void loginOntap() async {
    await validateInputs();
    if (emailError.isEmpty && passwordError.isEmpty) {
      Get.snackbar('Sign up', 'Sign up successful');
      Get.toNamed(Routes.main);
      prefs.setBool('isLoggin', true);
    }
  }
}
