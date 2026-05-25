import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/usecases/calculate_cycle_prediction_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';

/// Loads calendar period, log, and prediction data.
class GetCalendarDataUseCase {
  const GetCalendarDataUseCase(
    this.periodTrackingRepository,
    this.dailyLogRepository,
    this.calculateCyclePredictionUseCase,
  );

  final PeriodTrackingRepository periodTrackingRepository;
  final DailyLogRepository dailyLogRepository;
  final CalculateCyclePredictionUseCase calculateCyclePredictionUseCase;

  Future<CalendarData> call() async => CalendarData(
    periods: await periodTrackingRepository.getPeriodHistory(),
    logs: await dailyLogRepository.getDailyLogs(),
    prediction: await calculateCyclePredictionUseCase(),
  );
}

class CalendarData {
  const CalendarData({
    required this.periods,
    required this.logs,
    required this.prediction,
  });

  final List<PeriodEntry> periods;
  final List<DailyLog> logs;
  final CyclePrediction prediction;
}
