import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';

/// Use case for loading period history.
class GetPeriodHistoryUseCase {
  const GetPeriodHistoryUseCase(this.repository);

  final PeriodTrackingRepository repository;

  Future<List<PeriodEntry>> call() => repository.getPeriodHistory();
}
