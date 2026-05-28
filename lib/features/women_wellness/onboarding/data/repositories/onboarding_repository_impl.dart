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

  @override
  Future<bool> isSetupCompleted() async =>
      storageService.getBool(
        _userScopedKey(WellnessStorageKeys.setupOnboardingComplete),
      ) ??
      false;

  @override
  Future<void> completeSetup({
    required String goal,
    required DateTime lastPeriodStart,
    required int cycleLength,
    required int periodLength,
  }) async {
    await storageService.setString(
      _userScopedKey(WellnessStorageKeys.setupGoal),
      goal,
    );
    await storageService.setString(
      _userScopedKey(WellnessStorageKeys.setupLastPeriodStart),
      lastPeriodStart.toIso8601String(),
    );
    await storageService.setInt(
      _userScopedKey(WellnessStorageKeys.setupCycleLength),
      cycleLength,
    );
    await storageService.setInt(
      _userScopedKey(WellnessStorageKeys.setupPeriodLength),
      periodLength,
    );
    await storageService.setBool(
      _userScopedKey(WellnessStorageKeys.setupOnboardingComplete),
      true,
    );
  }

  String _userScopedKey(String key) {
    final userId = storageService.getString(WellnessStorageKeys.currentUserId);
    if (userId == null || userId.isEmpty) return key;
    return '${key}_$userId';
  }
}
