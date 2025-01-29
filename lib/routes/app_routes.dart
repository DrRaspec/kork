import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/views/change_password_view.dart';
import 'package:kork/views/forget_password_view.dart';
import 'package:kork/views/home_view.dart';
import 'package:kork/views/login_view.dart';
import 'package:kork/views/profile_view.dart';
import 'package:kork/views/sign_up_view.dart';
import 'package:kork/views/verify_otp_view.dart';

var appRoutes = [
  GetPage(
    name: Routes.login,
    page: () => const LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: Routes.signup,
    page: () => const SignUpView(),
    binding: SignUpBinding(),
  ),
  GetPage(
    name: Routes.profile,
    page: () => const ProfileView(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: Routes.forgetPassword,
    page: () => const ForgetPasswordView(),
    binding: ForgetPasswordBinding(),
  ),
  GetPage(
    name: Routes.verifyOtp,
    page: () => const VerifyOtpView(),
    binding: VerifyOtpBinding(),
  ),
  GetPage(
    name: Routes.changePassword,
    page: () => const ChangePasswordView(),
    binding: ChangePasswordBinding(),
  ),
  GetPage(
    name: Routes.home,
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
];
