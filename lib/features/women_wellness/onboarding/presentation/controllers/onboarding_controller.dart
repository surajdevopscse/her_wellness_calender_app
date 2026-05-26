import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/usecases/complete_onboarding_usecase.dart';

class OnboardingController extends GetxController {
  OnboardingController(this.completeOnboardingUseCase);

  final CompleteOnboardingUseCase completeOnboardingUseCase;
  final pageIndex = 0.obs;

  static const slides = [
    (
      'Private wellness tracking, designed to feel calm',
      'Follow your cycle in a way that feels discreet, supportive, and easy to keep up with.',
      'shield_outlined',
    ),
    (
      'Check in quickly, without overthinking it',
      'Log flow, mood, pain, sleep, and symptoms in under a minute.',
      'calendar_month_outlined',
    ),
    (
      'See your rhythm more clearly over time',
      'Understand upcoming periods, ovulation timing, and recurring symptom patterns.',
      'insights_outlined',
    ),
    (
      'Stay in control of privacy from the start',
      'Use discreet reminders, protect the app, and remove data whenever you choose.',
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

  void previous() {
    if (pageIndex.value > 0) {
      pageIndex.value--;
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
