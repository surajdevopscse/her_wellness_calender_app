import 'package:get/get.dart';

import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/core/network/network_info.dart';
import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/core/storage/storage_service.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/data/datasources/daily_log_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/data/datasources/daily_log_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/data/repositories/daily_log_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/datasources/privacy_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/datasources/privacy_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/repositories/privacy_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/datasources/period_tracking_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/datasources/period_tracking_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/repositories/period_tracking_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/datasources/wellness_profile_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/datasources/wellness_profile_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/repositories/wellness_profile_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/data/datasources/reminders_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/data/datasources/reminders_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/data/repositories/reminders_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/repositories/reminders_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/data/datasources/reports_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/data/datasources/reports_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/data/repositories/reports_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/data/datasources/symptoms_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/data/datasources/symptoms_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/data/repositories/symptoms_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/repositories/symptoms_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/data/datasources/auth_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/data/repositories/auth_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/data/datasources/notifications_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/domain/repositories/notifications_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/data/datasources/settings_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/data/datasources/settings_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/data/repositories/settings_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/repositories/settings_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/core/services/theme_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/data/repositories/data_export_repository_impl.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/data/services/wellness_export_file_writer.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/repositories/data_export_repository.dart';
import 'package:her_wellness_calender/app/environment/app_environment.dart';

/// Registers app-wide services and repository abstractions.
class AppDependencies {
  AppDependencies._();

  static Future<void> initialize({
    AppEnvironment environment = AppEnvironment.mock,
  }) async {
    Get.put<AppEnvironment>(environment, permanent: true);

    final storageService = StorageService();
    await storageService.init();
    Get.put<StorageService>(storageService, permanent: true);

    Get.put<MockAssetLoader>(DefaultMockAssetLoader(), permanent: true);
    Get.put<NetworkInfo>(const NetworkInfoImpl(), permanent: true);
    Get.put<ApiClient>(
      ApiClient(
        baseUrl: environment.baseUrl,
        connectTimeout: environment.connectTimeout,
        receiveTimeout: environment.receiveTimeout,
        enableLogs: environment.enableApiLogs,
        getToken: () => storageService.getAuthToken(),
      ),
      permanent: true,
    );

    Get.lazyPut<WellnessProfileMockDatasource>(
      () => WellnessProfileMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<WellnessProfileRemoteDatasource>(
      () => WellnessProfileRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<WellnessProfileRepository>(
      () => WellnessProfileRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<WellnessProfileMockDatasource>(),
        remoteDatasource: Get.find<WellnessProfileRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<PrivacyMockDatasource>(
      () => PrivacyMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<PrivacyRemoteDatasource>(
      () => PrivacyRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<PrivacyRepository>(
      () => PrivacyRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<PrivacyMockDatasource>(),
        remoteDatasource: Get.find<PrivacyRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<PeriodTrackingMockDatasource>(
      () => PeriodTrackingMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<PeriodTrackingRemoteDatasource>(
      () => PeriodTrackingRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<PeriodTrackingRepository>(
      () => PeriodTrackingRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<PeriodTrackingMockDatasource>(),
        remoteDatasource: Get.find<PeriodTrackingRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<DailyLogMockDatasource>(
      () => DailyLogMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<DailyLogRemoteDatasource>(
      () => DailyLogRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<DailyLogRepository>(
      () => DailyLogRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<DailyLogMockDatasource>(),
        remoteDatasource: Get.find<DailyLogRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<ReportsMockDatasource>(
      () => ReportsMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<ReportsRemoteDatasource>(
      () => ReportsRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<ReportsRepository>(
      () => ReportsRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<ReportsMockDatasource>(),
        remoteDatasource: Get.find<ReportsRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<RemindersMockDatasource>(
      () => RemindersMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<RemindersRemoteDatasource>(
      () => RemindersRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<RemindersRepository>(
      () => RemindersRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<RemindersMockDatasource>(),
        remoteDatasource: Get.find<RemindersRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SymptomsMockDatasource>(
      () => SymptomsMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<SymptomsRemoteDatasource>(
      () => SymptomsRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<SymptomsRepository>(
      () => SymptomsRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<SymptomsMockDatasource>(),
        remoteDatasource: Get.find<SymptomsRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AuthMockDatasource>(
      () => AuthMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<AuthMockDatasource>(),
        remoteDatasource: Get.find<AuthRemoteDatasource>(),
        storageService: Get.find<StorageService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepositoryImpl(Get.find<StorageService>()),
      fenix: true,
    );
    Get.lazyPut<SettingsMockDatasource>(
      () => SettingsMockDatasource(
        Get.find<MockAssetLoader>(),
        Get.find<StorageService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<SettingsRemoteDatasource>(
      () => SettingsRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<SettingsRepository>(
      () => SettingsRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<SettingsMockDatasource>(),
        remoteDatasource: Get.find<SettingsRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<NotificationsMockDatasource>(
      () => NotificationsMockDatasource(Get.find<MockAssetLoader>()),
      fenix: true,
    );
    Get.lazyPut<NotificationsRemoteDatasource>(
      () => NotificationsRemoteDatasource(Get.find<ApiClient>()),
      fenix: true,
    );
    Get.lazyPut<NotificationsRepository>(
      () => NotificationsRepositoryImpl(
        environment: Get.find<AppEnvironment>(),
        mockDatasource: Get.find<NotificationsMockDatasource>(),
        remoteDatasource: Get.find<NotificationsRemoteDatasource>(),
      ),
      fenix: true,
    );
    Get.put<ThemeController>(
      ThemeController(Get.find<SettingsRepository>()),
      permanent: true,
    );
    Get.lazyPut<WellnessExportFileWriter>(
      () => const WellnessExportFileWriter(),
      fenix: true,
    );
    Get.lazyPut<DataExportRepository>(
      () => DataExportRepositoryImpl(
        profileRepository: Get.find<WellnessProfileRepository>(),
        periodRepository: Get.find<PeriodTrackingRepository>(),
        dailyLogRepository: Get.find<DailyLogRepository>(),
        privacyRepository: Get.find<PrivacyRepository>(),
        remindersRepository: Get.find<RemindersRepository>(),
        symptomsRepository: Get.find<SymptomsRepository>(),
        reportsRepository: Get.find<ReportsRepository>(),
        fileWriter: Get.find<WellnessExportFileWriter>(),
      ),
      fenix: true,
    );
  }
}
