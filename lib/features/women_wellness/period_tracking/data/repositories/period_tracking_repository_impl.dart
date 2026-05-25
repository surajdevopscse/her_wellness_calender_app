import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/datasources/period_tracking_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/datasources/period_tracking_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/models/period_entry_model.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';

/// Repository implementation that switches between mock and remote period APIs.
class PeriodTrackingRepositoryImpl implements PeriodTrackingRepository {
  const PeriodTrackingRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final PeriodTrackingMockDatasource mockDatasource;
  final PeriodTrackingRemoteDatasource remoteDatasource;

  @override
  Future<List<PeriodEntry>> getPeriodHistory() async {
    final response = environment.isMockMode
        ? await mockDatasource.getPeriodHistory()
        : await remoteDatasource.getPeriodHistory();
    final data = response['data'] as List<dynamic>? ?? const [];
    return data
        .map(
          (item) => PeriodEntryModel.fromJson(
            item as Map<String, dynamic>,
          ).toEntity(),
        )
        .toList();
  }

  @override
  Future<PeriodEntry> addPeriodEntry(PeriodEntry entry) async {
    final payload = PeriodEntryModel.fromEntity(entry).toJson();
    final response = environment.isMockMode
        ? await mockDatasource.addPeriodEntry(payload)
        : await remoteDatasource.addPeriodEntry(payload);
    return PeriodEntryModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<PeriodEntry> updatePeriodEntry(PeriodEntry entry) async {
    final payload = PeriodEntryModel.fromEntity(entry).toJson();
    final response = environment.isMockMode
        ? await mockDatasource.updatePeriodEntry(payload)
        : await remoteDatasource.updatePeriodEntry(payload);
    return PeriodEntryModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<void> deletePeriodEntry(String id) async {
    if (environment.isMockMode) {
      await mockDatasource.deletePeriodEntry(id);
    } else {
      await remoteDatasource.deletePeriodEntry(id);
    }
  }
}
