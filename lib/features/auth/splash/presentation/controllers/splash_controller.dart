import 'package:get/get.dart';

import 'package:her_wellness_calender/core/storage/storage_service.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class SplashController extends GetxController {
  SplashController(this.onboardingRepository, this.storageService);

  final OnboardingRepository onboardingRepository;
  final StorageService storageService;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _boot();
  }

  Future<void> _boot() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    final onboardingDone = await onboardingRepository.isCompleted();

    if (!onboardingDone) {
      isLoading.value = false;
      Get.offAllNamed(AuthenticationRoutes.onboarding);
      return;
    }

    final token = storageService.getAuthToken();

    isLoading.value = false;

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(WellnessRoutes.dashboard);
    } else {
      Get.offAllNamed(AuthenticationRoutes.login);
    }
  }
}
