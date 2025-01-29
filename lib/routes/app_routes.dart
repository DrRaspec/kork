import 'package:get/get.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/login_view.dart';
import 'package:kork/screens/profile_view.dart';

var appRoutes = [
  GetPage(
    name: Routes.login,
    page: () => const LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: Routes.profile,
    page: () => const ProfileView(),
    binding: ProfileBinding(),
  ),
];
