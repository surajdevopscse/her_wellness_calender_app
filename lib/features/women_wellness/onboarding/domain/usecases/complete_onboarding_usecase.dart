import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this.repository);
  final OnboardingRepository repository;
  Future<void> call() => repository.complete();
}
