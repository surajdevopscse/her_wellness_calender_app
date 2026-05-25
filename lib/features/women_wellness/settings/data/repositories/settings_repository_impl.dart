import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/data/datasources/settings_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/data/datasources/settings_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/data/models/app_settings_model.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/entities/app_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final SettingsMockDatasource mockDatasource;
  final SettingsRemoteDatasource remoteDatasource;

  @override
  Future<AppSettings> getSettings() async {
    if (environment.isMockMode) {
      final stored = mockDatasource.readThemeMode();
      final payload = await mockDatasource.loadDefaults();
      final model = AppSettingsModel.fromJson(
        payload['data'] as Map<String, dynamic>,
      );
      if (stored != null) {
        return model.toEntity().copyWith(
          themeMode: switch (stored) {
            'light' => AppThemeMode.light,
            'dark' => AppThemeMode.dark,
            _ => AppThemeMode.system,
          },
        );
      }
      return model.toEntity();
    }
    final response = await remoteDatasource.getSettings();
    return AppSettingsModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<AppSettings> updateSettings(AppSettings settings) async {
    final json = AppSettingsModel.fromEntity(settings).toJson();
    if (environment.isMockMode) {
      await mockDatasource.saveThemeMode(settings.themeMode.name);
      return settings;
    }
    final response = await remoteDatasource.updateSettings(json);
    return AppSettingsModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }
}
