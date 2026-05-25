import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';

/// Contract for period tracking history and entry mutations.
abstract class PeriodTrackingRepository {
  /// Returns period entries ordered by newest first.
  Future<List<PeriodEntry>> getPeriodHistory();

  /// Adds a confirmed period entry.
  Future<PeriodEntry> addPeriodEntry(PeriodEntry entry);

  /// Updates an existing period entry.
  Future<PeriodEntry> updatePeriodEntry(PeriodEntry entry);

  /// Deletes a period entry by id.
  Future<void> deletePeriodEntry(String id);
}
