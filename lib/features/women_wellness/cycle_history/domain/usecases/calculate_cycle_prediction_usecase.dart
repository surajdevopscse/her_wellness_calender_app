import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_prediction_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';

/// Calculates or retrieves current cycle prediction.
class CalculateCyclePredictionUseCase {
  const CalculateCyclePredictionUseCase(
    this.profileRepository,
    this.periodTrackingRepository,
  );

  final WellnessProfileRepository profileRepository;
  final PeriodTrackingRepository periodTrackingRepository;

  Future<CyclePrediction> call() async {
    final profile = await profileRepository.getProfile();
    if (profile == null) {
      throw StateError('Wellness profile is required for cycle prediction.');
    }
    final periods = await periodTrackingRepository.getPeriodHistory();
    final irregular = periods.any(
      (entry) => entry.irregularCycleNote?.isNotEmpty ?? false,
    );
    return WellnessPredictionHelper.calculate(
      lastPeriodStartDate: profile.lastPeriodStartDate,
      averageCycleLength: profile.averageCycleLength,
      averagePeriodLength: profile.averagePeriodLength,
      today: DateTime.now(),
      isIrregular: irregular,
    );
  }
}
