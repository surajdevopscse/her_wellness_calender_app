import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';

/// Adds a daily wellness log.
class AddDailyLogUseCase {
  const AddDailyLogUseCase(this.repository);

  final DailyLogRepository repository;

  Future<DailyLog> call(DailyLog log) {
    if (log.medicineTaken && (log.medicineName?.trim().isEmpty ?? true)) {
      throw ArgumentError(WellnessConstants.medicineNameRequired);
    }
    return repository.addDailyLog(log);
  }
}
