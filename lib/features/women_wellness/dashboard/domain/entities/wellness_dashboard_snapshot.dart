import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';

class WellnessDashboardSnapshot {
  const WellnessDashboardSnapshot({
    required this.profile,
    required this.periods,
    required this.logs,
    required this.report,
  });

  final WellnessProfile profile;
  final List<PeriodEntry> periods;
  final List<DailyLog> logs;
  final WellnessReport report;
}
