import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';

/// Deletes a daily wellness log.
class DeleteDailyLogUseCase {
  const DeleteDailyLogUseCase(this.repository);

  final DailyLogRepository repository;

  Future<void> call(String id) => repository.deleteDailyLog(id);
}
