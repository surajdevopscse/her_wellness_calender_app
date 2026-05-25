import 'package:her_wellness_calender/core/storage/storage_service.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_storage_keys.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this.storageService);

  final StorageService storageService;

  @override
  Future<bool> isCompleted() async =>
      storageService.getBool(WellnessStorageKeys.onboardingComplete) ?? false;

  @override
  Future<void> complete() =>
      storageService.setBool(WellnessStorageKeys.onboardingComplete, true);
}
