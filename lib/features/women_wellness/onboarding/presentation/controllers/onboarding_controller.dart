import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/usecases/complete_onboarding_usecase.dart';

class OnboardingController extends GetxController {
  OnboardingController(this.completeOnboardingUseCase);

  final CompleteOnboardingUseCase completeOnboardingUseCase;
  final pageIndex = 0.obs;

  static const slides = [
    (
      'Welcome to private wellness tracking',
      'Your cycle data stays discreet and under your control.',
      'shield_outlined',
    ),
    (
      'Track periods and symptoms',
      'Log flow, mood, pain, sleep, and habits in seconds.',
      'calendar_month_outlined',
    ),
    (
      'Understand cycle predictions',
      'See fertile windows, ovulation, and PMS estimates.',
      'insights_outlined',
    ),
    (
      'Privacy and security first',
      'Lock the app, hide notification text, and delete data anytime.',
      'lock_person_outlined',
    ),
  ];

  void next() {
    if (pageIndex.value < slides.length - 1) {
      pageIndex.value++;
    } else {
      finish();
    }
  }

  Future<void> finish() async {
    await completeOnboardingUseCase();
    Get.offAllNamed(AuthenticationRoutes.login);
  }

  void goLogin() async {
    await completeOnboardingUseCase();
    Get.offAllNamed(AuthenticationRoutes.login);
  }

  void goRegister() async {
    await completeOnboardingUseCase();
    Get.offAllNamed(AuthenticationRoutes.register);
  }
}
