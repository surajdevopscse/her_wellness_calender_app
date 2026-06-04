import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/core/storage/storage_service.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_storage_keys.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl({
    required this.storageService,
    required this.environment,
    required this.remoteDatasource,
  });

  final StorageService storageService;
  final AppEnvironment environment;
  final OnboardingRemoteDatasource remoteDatasource;

  @override
  Future<bool> isCompleted() async =>
      storageService.getBool(WellnessStorageKeys.onboardingComplete) ?? false;

  @override
  Future<void> complete() =>
      storageService.setBool(WellnessStorageKeys.onboardingComplete, true);

  @override
  Future<bool> isSetupCompleted() async {
    final cachedStatus =
        storageService.getBool(
          _userScopedKey(WellnessStorageKeys.setupOnboardingComplete),
        ) ??
        false;

    if (environment.isMockMode) return cachedStatus;

    try {
      final status = await remoteDatasource.getStatus();
      await storageService.setBool(
        _userScopedKey(WellnessStorageKeys.setupOnboardingComplete),
        status.isCompleted,
      );
      return status.isCompleted;
    } on NetworkAppException {
      return cachedStatus;
    } on TimeoutAppException {
      return cachedStatus;
    } on ServerAppException {
      return cachedStatus;
    }
  }

  @override
  Future<void> completeSetup({
    required String goal,
    required DateTime lastPeriodStart,
    required int cycleLength,
    required int periodLength,
  }) async {
    if (!environment.isMockMode) {
      await remoteDatasource.completeSetup(
        goal: goal,
        lastPeriodStart: lastPeriodStart,
        cycleLength: cycleLength,
        periodLength: periodLength,
      );
    }

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
