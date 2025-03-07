import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/checkout/checkout_view.dart';
import 'package:kork/screens/choose_language/choose_language_view.dart';
import 'package:kork/screens/contact_organizer/contact_organizer_view.dart';
import 'package:kork/screens/event_detail/booked_event/booked_event_detail_view.dart';
import 'package:kork/screens/event_member/event_member_view.dart';
import 'package:kork/screens/on_boarding/first_onboarding_view.dart';
import 'package:kork/screens/update_password/change_password/change_password_view.dart';
import 'package:kork/screens/event_detail/event_detail.dart';
import 'package:kork/screens/main_screens/event/event_view.dart';
import 'package:kork/screens/filter_screens/filter_location/filter_location.dart';
import 'package:kork/screens/filter_screens/filter/filter_view.dart';
import 'package:kork/screens/filter_screens/filtered/filtered_view.dart';
import 'package:kork/screens/search_event/search_event.dart';
import 'package:kork/screens/sign_up_view/first_signup/first_signup_view.dart';
import 'package:kork/screens/update_password/forget_password/forget_password_view.dart';
import 'package:kork/screens/main_screens/home/home_view.dart';
import 'package:kork/screens/login/login_view.dart';
import 'package:kork/screens/main/main_view.dart';
import 'package:kork/screens/sign_up_view/map/map_view.dart';
import 'package:kork/screens/main_screens/profile/profile_view.dart';
import 'package:kork/screens/sign_up_view/select_location/select_location_view.dart';
import 'package:kork/screens/sign_up_view/select_profile/select_profile_view.dart';
import 'package:kork/screens/sign_up_view/signup/sign_up_view.dart';
import 'package:kork/screens/update_password/verify_otp/verify_otp_view.dart';

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
  GetPage(
    name: Routes.checkout,
    page: () => const CheckoutView(),
    binding: CheckoutBinding(),
  ),
  GetPage(
    name: Routes.eventMember,
    page: () => EventMemberView(),
    binding: EventMemberViewBinding(),
  ),
  GetPage(
    name: Routes.contactOrganizer,
    page: () => ContactOrganizerView(),
    binding: ContactOrganizerBinding(),
  ),
  GetPage(
    name: Routes.firstOnBoarding,
    page: () => FirstOnboardingView(),
    binding: FirstOnboardingBinding(),
  ),
  GetPage(
    name: Routes.chooseLanguage,
    page: () => ChooseLanguageView(),
    binding: ChooseLanguageViewBinding(),
  ),
];
