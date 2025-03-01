import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/views/booked_event_detail_view.dart';
import 'package:kork/views/forget_password_view/change_password_view.dart';
import 'package:kork/views/event_detail.dart';
import 'package:kork/views/main_view/event_view.dart';
import 'package:kork/views/filter_views/filter_location.dart';
import 'package:kork/views/filter_views/filter_view.dart';
import 'package:kork/views/filter_views/filtered_view.dart';
import 'package:kork/views/search_event.dart';
import 'package:kork/views/sign_up_view/first_signup_view.dart';
import 'package:kork/views/forget_password_view/forget_password_view.dart';
import 'package:kork/views/main_view/home_view.dart';
import 'package:kork/views/login_view.dart';
import 'package:kork/views/main_view.dart';
import 'package:kork/views/sign_up_view/map_view.dart';
import 'package:kork/views/main_view/profile_view.dart';
import 'package:kork/views/sign_up_view/select_location_view.dart';
import 'package:kork/views/sign_up_view/select_profile_view.dart';
import 'package:kork/views/sign_up_view/sign_up_view.dart';
import 'package:kork/views/forget_password_view/verify_otp_view.dart';

var appRoutes = [
  GetPage(
    name: Routes.login,
    page: () => const LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: Routes.firstSignup,
    page: () => const FirstSignupView(),
    binding: FirstSignupBinding(),
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
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.verifyOtp,
    page: () => const VerifyOtpView(),
    binding: VerifyOtpBinding(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.changePassword,
    page: () => const ChangePasswordView(),
    binding: ChangePasswordBinding(),
    transition: Transition.cupertino,
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
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: Routes.eventScreen,
    page: () => const EventView(),
    binding: EventBinding(),
    transition: Transition.leftToRight,
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
  GetPage(
    name: Routes.bookedEvent,
    page: () => const BookedEventDetailView(),
    binding: BookedEventDetailBinding(),
  ),
  GetPage(
    name: Routes.selectProfile,
    page: () => const SelectProfileView(),
    binding: SelectProfileBinding(),
  ),
  GetPage(
    name: Routes.selectLocation,
    page: () => const SelectLocationView(),
    binding: SelectLocationBinding(),
  ),
  GetPage(
    name: Routes.mapView,
    page: () => const MapView(),
    binding: MapBinding(),
  ),
  GetPage(
    name: Routes.searchEvent,
    page: () => const SearchEvent(),
    binding: SearchEventBinding(),
  ),
];
