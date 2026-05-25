import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/usecases/calculate_cycle_prediction_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';

/// Loads all data needed by the dashboard.
class GetWellnessDashboardUseCase {
  const GetWellnessDashboardUseCase(
    this.profileRepository,
    this.periodTrackingRepository,
    this.dailyLogRepository,
    this.reportsRepository,
    this.calculateCyclePredictionUseCase,
  );

  final WellnessProfileRepository profileRepository;
  final PeriodTrackingRepository periodTrackingRepository;
  final DailyLogRepository dailyLogRepository;
  final ReportsRepository reportsRepository;
  final CalculateCyclePredictionUseCase calculateCyclePredictionUseCase;

  Future<WellnessDashboardData> call() async {
    final profile = await profileRepository.getProfile();
    if (profile == null) {
      throw StateError('Wellness profile is required for dashboard.');
    }
    return WellnessDashboardData(
      profile: profile,
      periods: await periodTrackingRepository.getPeriodHistory(),
      logs: await dailyLogRepository.getDailyLogs(),
      prediction: await calculateCyclePredictionUseCase(),
      report: await reportsRepository.getReports(),
    );
  }
}

/// Dashboard aggregate returned by the dashboard use case.
class WellnessDashboardData {
  const WellnessDashboardData({
    required this.profile,
    required this.periods,
    required this.logs,
    required this.prediction,
    required this.report,
  });

  final WellnessProfile profile;
  final List<PeriodEntry> periods;
  final List<DailyLog> logs;
  final CyclePrediction prediction;
  final WellnessReport report;
}
