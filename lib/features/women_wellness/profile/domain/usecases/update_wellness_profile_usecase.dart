import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_validators.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';

/// Use case for validating and saving wellness profile baseline fields.
class UpdateWellnessProfileUseCase {
  const UpdateWellnessProfileUseCase(this.repository);

  final WellnessProfileRepository repository;

  /// Validates cycle baseline values before persisting the profile.
  Future<WellnessProfile> call(WellnessProfile profile) {
    final cycleError = WellnessValidators.validateCycleLength(
      profile.averageCycleLength,
    );
    if (cycleError != null) {
      throw ArgumentError(cycleError);
    }

    final periodError = WellnessValidators.validatePeriodLength(
      profile.averagePeriodLength,
    );
    if (periodError != null) {
      throw ArgumentError(periodError);
    }

    return repository.updateProfile(profile);
  }
}
