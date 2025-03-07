part of 'first_onboarding_view.dart';

class FirstOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirstOnboardingController());
  }
}
