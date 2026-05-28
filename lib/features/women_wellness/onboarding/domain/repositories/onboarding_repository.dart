abstract class OnboardingRepository {
  Future<bool> isCompleted();
  Future<void> complete();
  Future<bool> isSetupCompleted();
  Future<void> completeSetup({
    required String goal,
    required DateTime lastPeriodStart,
    required int cycleLength,
    required int periodLength,
  });
}
