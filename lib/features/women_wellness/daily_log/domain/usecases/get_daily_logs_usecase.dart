import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';

/// Use case for loading daily wellness logs.
class GetDailyLogsUseCase {
  const GetDailyLogsUseCase(this.repository);

  final DailyLogRepository repository;

  Future<List<DailyLog>> call({DateTime? startDate, DateTime? endDate}) {
    return repository.getDailyLogs(startDate: startDate, endDate: endDate);
  }
}
