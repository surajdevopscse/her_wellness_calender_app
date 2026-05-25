import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class IsOnboardingCompleteUseCase {
  const IsOnboardingCompleteUseCase(this.repository);
  final OnboardingRepository repository;
  Future<bool> call() => repository.isCompleted();
}
