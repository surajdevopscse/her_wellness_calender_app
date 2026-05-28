import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/usecases/complete_setup_onboarding_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/presentation/controllers/setup_onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CompleteOnboardingUseCase(Get.find<OnboardingRepository>()),
    );
    Get.lazyPut(
      () => OnboardingController(Get.find<CompleteOnboardingUseCase>()),
    );
    Get.lazyPut(
      () => CompleteSetupOnboardingUseCase(Get.find<OnboardingRepository>()),
    );
    Get.lazyPut(
      () =>
          SetupOnboardingController(Get.find<CompleteSetupOnboardingUseCase>()),
    );
  }
}
