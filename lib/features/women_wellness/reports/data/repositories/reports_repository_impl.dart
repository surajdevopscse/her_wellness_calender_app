import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/data/datasources/reports_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/data/datasources/reports_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/data/models/wellness_report_model.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';

/// Repository implementation that switches between mock and remote reports.
class ReportsRepositoryImpl implements ReportsRepository {
  const ReportsRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final ReportsMockDatasource mockDatasource;
  final ReportsRemoteDatasource remoteDatasource;

  @override
  Future<WellnessReport> getReports({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final response = environment.isMockMode
        ? await mockDatasource.getReports()
        : await remoteDatasource.getReports(
            startDate: startDate,
            endDate: endDate,
          );
    return WellnessReportModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }
}
