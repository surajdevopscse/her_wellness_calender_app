import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class CompleteSetupOnboardingUseCase {
  const CompleteSetupOnboardingUseCase(this.repository);

  final OnboardingRepository repository;

  Future<void> call({
    required String goal,
    required DateTime lastPeriodStart,
    required int cycleLength,
    required int periodLength,
  }) => repository.completeSetup(
    goal: goal,
    lastPeriodStart: lastPeriodStart,
    cycleLength: cycleLength,
    periodLength: periodLength,
  );
}
