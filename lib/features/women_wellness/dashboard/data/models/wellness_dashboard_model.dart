import 'package:her_wellness_calender/features/women_wellness/daily_log/data/models/daily_log_model.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/entities/wellness_dashboard_snapshot.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/models/period_entry_model.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/models/wellness_profile_model.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/data/models/wellness_report_model.dart';

class WellnessDashboardModel {
  const WellnessDashboardModel({
    required this.profile,
    required this.periods,
    required this.logs,
    required this.report,
  });

  final WellnessProfileModel profile;
  final List<PeriodEntryModel> periods;
  final List<DailyLogModel> logs;
  final WellnessReportModel report;

  factory WellnessDashboardModel.fromJson(Map<String, dynamic> json) {
    return WellnessDashboardModel(
      profile: WellnessProfileModel.fromJson(
        json['profile'] as Map<String, dynamic>,
      ),
      periods: (json['periods'] as List<dynamic>? ?? const [])
          .map((item) => PeriodEntryModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      logs: (json['logs'] as List<dynamic>? ?? const [])
          .map((item) => DailyLogModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      report: WellnessReportModel.fromJson(
        json['report'] as Map<String, dynamic>,
      ),
    );
  }

  WellnessDashboardSnapshot toEntity() => WellnessDashboardSnapshot(
    profile: profile.toEntity(),
    periods: periods.map((item) => item.toEntity()).toList(),
    logs: logs.map((item) => item.toEntity()).toList(),
    report: report.toEntity(),
  );
}
