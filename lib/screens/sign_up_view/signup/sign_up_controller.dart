part of 'sign_up_view.dart';

class SignUpController extends GetxController with GetTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();

  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  var passwordVisible = true.obs;
  var confirmPasswordVisible = true.obs;

  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode confirmPasswordFocus;

  late AnimationController emailShakeController;
  late AnimationController passwordShakeController;
  late AnimationController confirmPasswordShakeController;

  late Animation<double> emailShakeAnimation;
  late Animation<double> passwordShakeAnimation;
  late Animation<double> confirmPasswordShakeAnimation;

  var status = Status.success.obs;

  Timer? debounce;

  // var isNew = Get.find<VerifyOtpView>().controller.isNew;

  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();

    emailShakeController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    passwordShakeController = AnimationController(
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

    emailShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(emailShakeController);

    passwordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(passwordShakeController);

    confirmPasswordShakeAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(confirmPasswordShakeController);
  }

  void triggerEmailShake() {
    emailShakeController.forward(from: 0);
  }

  void trigglePasswordShake() {
    passwordShakeController.forward(from: 0);
  }

  void triggleConfirmPasswordShake() {
    confirmPasswordShakeController.forward(from: 0);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    conPasswordController.dispose();
    emailShakeController.dispose();
    passwordShakeController.dispose();
    confirmPasswordShakeController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }

  Future<void> validateInput() async {
    var url = dotenv.env['API_URL']!;
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    bool hasError = false;
    dio.interceptors.add(AppLogInterceptor());
    try {
      status.value = Status.loading;
      var response = await dio.post(
        '$url/check-email',
        data: {'email': emailController.text},
        options: Options(
          headers: {'content-type': 'application/json'},
          validateStatus: (status) {
            return status != null && status >= 200 && status <= 409;
          },
        ),
      );
      var result = response.data as Map<String, dynamic>;

      status.value = Status.success;

      if (emailController.text.trim().isEmpty) {
        emailError.value =
            '${AppLocalizations.of(Get.context!)!.email} ${AppLocalizations.of(Get.context!)!.cant_empty}';
        triggerEmailShake();
        hasError = true;
      } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(emailController.text.trim())) {
        emailError.value = AppLocalizations.of(Get.context!)!.invalid_email;
        triggerEmailShake();
        hasError = true;
      } else if (result['email'] == 'Email already exists') {
        emailError.value =
            AppLocalizations.of(Get.context!)!.email_already_registered;
        triggerEmailShake();
        hasError = true;
      }

      if (passwordController.text.isEmpty) {
        passwordError.value =
            '${AppLocalizations.of(Get.context!)!.password}${AppLocalizations.of(Get.context!)!.cant_empty}';
        trigglePasswordShake();
        hasError = true;
      } else if (passwordController.text.length < 8 ||
          !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
              .hasMatch(passwordController.text)) {
        passwordError.value = AppLocalizations.of(Get.context!)!.password_quide;
        trigglePasswordShake();
        hasError = true;
      }

      if (conPasswordController.text.isEmpty) {
        confirmPasswordError.value =
            '${AppLocalizations.of(Get.context!)!.confirm_password}${AppLocalizations.of(Get.context!)!.cant_empty}';
        triggleConfirmPasswordShake();
        hasError = true;
      } else if (conPasswordController.text != passwordController.text) {
        confirmPasswordError.value =
            AppLocalizations.of(Get.context!)!.password_not_match;
        trigglePasswordShake();
        hasError = true;
      }

      if (hasError) {
        Future.delayed(
          Duration.zero,
          () {
            if (emailError.isNotEmpty) {
              emailFocus.requestFocus();
            } else if (passwordError.isNotEmpty) {
              passwordFocus.requestFocus();
            } else if (confirmPasswordError.isNotEmpty) {
              confirmPasswordFocus.requestFocus();
            }
          },
        );
      }
    } on DioException catch (e) {
      status.value = Status.error;
    }
  }

  void onTap() async {
    await validateInput();
    if (emailError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty) {
      Get.toNamed(Routes.verifyOtp, arguments: true);
    }
  }

  // void onChange(String value) {
  //   if (debounce?.isActive ?? false) debounce?.cancel();
  //   debounce = Timer(
  //     const Duration(milliseconds: 200),
  //     () => checkUniqueEmail(),
  //   );
  // }
}
