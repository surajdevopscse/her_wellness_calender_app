import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/data/models/wellness_dashboard_model.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/entities/wellness_dashboard_snapshot.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl({
    required this.environment,
    required this.remoteDatasource,
    required this.profileRepository,
    required this.periodRepository,
    required this.dailyLogRepository,
    required this.reportsRepository,
  });

  final AppEnvironment environment;
  final DashboardRemoteDatasource remoteDatasource;
  final WellnessProfileRepository profileRepository;
  final PeriodTrackingRepository periodRepository;
  final DailyLogRepository dailyLogRepository;
  final ReportsRepository reportsRepository;

  @override
  Future<WellnessDashboardSnapshot?> getDashboard() async {
    if (!environment.isMockMode) {
      final response = await remoteDatasource.getDashboard();
      final data = response['data'];
      if (data == null) return null;
      return WellnessDashboardModel.fromJson(
        data as Map<String, dynamic>,
      ).toEntity();
    }

    final profile = await profileRepository.getProfile();
    if (profile == null) return null;
    return WellnessDashboardSnapshot(
      profile: profile,
      periods: await periodRepository.getPeriodHistory(),
      logs: await dailyLogRepository.getDailyLogs(),
      report: await reportsRepository.getReports(),
    );
  }
}
