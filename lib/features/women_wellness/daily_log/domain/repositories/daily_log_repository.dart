import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';

/// Contract for daily wellness log history and mutations.
abstract class DailyLogRepository {
  /// Returns logs filtered by optional date range.
  Future<List<DailyLog>> getDailyLogs({DateTime? startDate, DateTime? endDate});

  /// Adds a new daily log.
  Future<DailyLog> addDailyLog(DailyLog log);

  /// Updates an existing daily log.
  Future<DailyLog> updateDailyLog(DailyLog log);

  /// Deletes a daily log by id.
  Future<void> deleteDailyLog(String id);
}
