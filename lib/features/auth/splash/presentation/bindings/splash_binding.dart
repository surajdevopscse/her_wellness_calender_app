import 'package:get/get.dart';

import 'package:her_wellness_calender/core/storage/storage_service.dart';
import 'package:her_wellness_calender/features/auth/splash/presentation/controllers/splash_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(
        Get.find<OnboardingRepository>(),
        Get.find<StorageService>(),
      ),
    );
  }
}
