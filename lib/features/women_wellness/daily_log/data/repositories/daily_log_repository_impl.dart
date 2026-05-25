import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/data/datasources/daily_log_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/data/datasources/daily_log_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/data/models/daily_log_model.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';

/// Repository implementation that switches between mock and remote daily log APIs.
class DailyLogRepositoryImpl implements DailyLogRepository {
  const DailyLogRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final DailyLogMockDatasource mockDatasource;
  final DailyLogRemoteDatasource remoteDatasource;

  @override
  Future<List<DailyLog>> getDailyLogs({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final response = environment.isMockMode
        ? await mockDatasource.getDailyLogs(
            startDate: startDate,
            endDate: endDate,
          )
        : await remoteDatasource.getDailyLogs(
            startDate: startDate,
            endDate: endDate,
          );
    final data = response['data'] as List<dynamic>? ?? const [];
    return data
        .map(
          (item) =>
              DailyLogModel.fromJson(item as Map<String, dynamic>).toEntity(),
        )
        .toList();
  }

  @override
  Future<DailyLog> addDailyLog(DailyLog log) async {
    final payload = DailyLogModel.fromEntity(log).toJson();
    final response = environment.isMockMode
        ? await mockDatasource.addDailyLog(payload)
        : await remoteDatasource.addDailyLog(payload);
    return DailyLogModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<DailyLog> updateDailyLog(DailyLog log) async {
    final payload = DailyLogModel.fromEntity(log).toJson();
    final response = environment.isMockMode
        ? await mockDatasource.updateDailyLog(payload)
        : await remoteDatasource.updateDailyLog(payload);
    return DailyLogModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<void> deleteDailyLog(String id) async {
    if (environment.isMockMode) {
      await mockDatasource.deleteDailyLog(id);
    } else {
      await remoteDatasource.deleteDailyLog(id);
    }
  }
}
