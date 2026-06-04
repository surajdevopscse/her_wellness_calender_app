import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_prediction_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';

/// Loads all data needed by the dashboard.
class GetWellnessDashboardUseCase {
  const GetWellnessDashboardUseCase(this.repository);

  final DashboardRepository repository;

  Future<WellnessDashboardData?> call() async {
    final snapshot = await repository.getDashboard();
    if (snapshot == null) return null;
    final irregular = snapshot.periods.any(
      (entry) => entry.irregularCycleNote?.isNotEmpty ?? false,
    );
    return WellnessDashboardData(
      profile: snapshot.profile,
      periods: snapshot.periods,
      logs: snapshot.logs,
      prediction: WellnessPredictionHelper.calculate(
        lastPeriodStartDate: snapshot.profile.lastPeriodStartDate,
        averageCycleLength: snapshot.profile.averageCycleLength,
        averagePeriodLength: snapshot.profile.averagePeriodLength,
        today: DateTime.now(),
        isIrregular: irregular,
      ),
      report: snapshot.report,
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
