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
  var isLoading = false.obs;

  late AnimationController emailShakeController;
  late AnimationController passwordShakeController;
  late Animation<double> emailShakeAnimation;
  late Animation<double> passwordShakeAnimation;

  var passwordObsecure = true.obs;

  @override
  void onInit() async {
    print(
        "LoginController: onInit called for ID ${hashCode} at ${DateTime.now()}");
    print("Current route: ${Get.currentRoute}");
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

  @override
  void onReady() {
    print("LoginController: onReady called at ${DateTime.now()}");
    super.onReady();
  }

  @override
  void onClose() {
    print("LoginController: Disposing with ID ${hashCode}");
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

    // if (!hasError) {
    //   hasError = await checkValidEmail();
    // }

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
    }
  }

  void loginOntap() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      await validateInputs();
      if (emailError.isEmpty && passwordError.isEmpty) {
        final authService = Get.find<AuthService>();

        try {
          // Directly call login method from checkValidEmail
          var response = await dio.post(
            'http://10.0.2.2:8000/api/login',
            data: {
              'email': emailController.text,
              'password': passwordController.text,
            },
            options: Options(
              headers: {'Accept': 'application/json'},
              contentType: 'application/json',
            ),
          );

          var userData = response.data as Map<String, dynamic>;

          // Directly login using AuthService
          await authService.login(
            token: userData['token'],
            id: userData['id'].toString(),
          );

          // Navigate to main screen
          Get.offAllNamed(Routes.main);
          Get.snackbar('Sign in', 'Signed in successfully');
        } on DioException catch (e) {
          _handleLoginError(e);
        }
      }
    } catch (e) {
      printError(info: 'Login error: $e');
      Get.snackbar('Error', 'An unexpected error occurred during login');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleLoginError(DioException e) {
    var response = e.response;
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
      Get.snackbar('Error',
          'Failed to connect to the server. Please check your internet connection.',
          snackPosition: SnackPosition.TOP);
    }
  }
}
