import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';

/// Adds a period entry after validation.
class AddPeriodEntryUseCase {
  const AddPeriodEntryUseCase(this.repository);

  final PeriodTrackingRepository repository;

  Future<PeriodEntry> call(PeriodEntry entry) {
    if (entry.endDate != null && entry.endDate!.isBefore(entry.startDate)) {
      throw ArgumentError(WellnessConstants.endBeforeStart);
    }
    return repository.addPeriodEntry(entry);
  }
}
