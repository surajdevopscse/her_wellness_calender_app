import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';

/// Deletes a period entry.
class DeletePeriodEntryUseCase {
  const DeletePeriodEntryUseCase(this.repository);

  final PeriodTrackingRepository repository;

  Future<void> call(String id) => repository.deletePeriodEntry(id);
}
