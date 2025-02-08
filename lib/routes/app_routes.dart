import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/views/change_password_view.dart';
import 'package:kork/views/event_detail.dart';
import 'package:kork/views/event_view.dart';
import 'package:kork/views/filter_location.dart';
import 'package:kork/views/filter_view.dart';
import 'package:kork/views/filtered_view.dart';
import 'package:kork/views/forget_password_view.dart';
import 'package:kork/views/home_view.dart';
import 'package:kork/views/login_view.dart';
import 'package:kork/views/main_view.dart';
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
    name: Routes.main,
    page: () => const MainView(),
    binding: MainBinding(),
  ),
  GetPage(
    name: Routes.home,
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: Routes.eventScreen,
    page: () => const EventView(),
    binding: EventBinding(),
  ),
  GetPage(
    name: Routes.filter,
    page: () => const FilterView(),
    binding: FilterBinding(),
  ),
  GetPage(
    name: Routes.filtered,
    page: () => const FilteredView(),
    binding: FilteredBinding(),
  ),
  GetPage(
    name: Routes.filterLocation,
    page: () => const FilterLocation(),
    binding: FilterLocationBinding(),
  ),
  GetPage(
    name: Routes.eventDetail,
    page: () => const EventDetail(),
    binding: EventDetailBinding(),
  ),
];
