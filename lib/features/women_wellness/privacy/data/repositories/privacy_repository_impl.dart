import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/datasources/privacy_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/datasources/privacy_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/models/privacy_settings_model.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';

/// Repository implementation that switches between mock and remote privacy APIs.
class PrivacyRepositoryImpl implements PrivacyRepository {
  const PrivacyRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final PrivacyMockDatasource mockDatasource;
  final PrivacyRemoteDatasource remoteDatasource;

  @override
  Future<PrivacySettings?> getSettings() async {
    final response = environment.isMockMode
        ? await mockDatasource.getSettings()
        : await remoteDatasource.getSettings();
    final data = response['data'];
    if (data == null) return null;
    return PrivacySettingsModel.fromJson(
      data as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<PrivacySettings> updateSettings(PrivacySettings settings) async {
    final payload = PrivacySettingsModel.fromEntity(settings).toJson();
    final response = environment.isMockMode
        ? await mockDatasource.updateSettings(payload)
        : await remoteDatasource.updateSettings(payload);
    return PrivacySettingsModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<void> deleteWellnessData() async {
    if (environment.isMockMode) {
      await mockDatasource.deleteWellnessData();
    } else {
      await remoteDatasource.deleteWellnessData();
    }
  }

  @override
  Future<void> deleteAccountAndData() async {
    if (environment.isMockMode) {
      await mockDatasource.deleteAccountAndData();
    } else {
      await remoteDatasource.deleteAccountAndData();
    }
  }
}
