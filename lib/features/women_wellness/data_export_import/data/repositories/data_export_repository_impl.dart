import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/data/models/daily_log_model.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/data/services/wellness_export_file_writer.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/export_file_result.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/wellness_export_bundle.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/repositories/data_export_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/data/models/period_entry_model.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/models/wellness_profile_model.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/models/privacy_settings_model.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/repositories/reminders_repository.dart';

class DataExportRepositoryImpl implements DataExportRepository {
  DataExportRepositoryImpl({
    required this.profileRepository,
    required this.periodRepository,
    required this.dailyLogRepository,
    required this.privacyRepository,
    required this.remindersRepository,
    required this.assetLoader,
    required this.fileWriter,
  });

  final WellnessProfileRepository profileRepository;
  final PeriodTrackingRepository periodRepository;
  final DailyLogRepository dailyLogRepository;
  final PrivacyRepository privacyRepository;
  final RemindersRepository remindersRepository;
  final MockAssetLoader assetLoader;
  final WellnessExportFileWriter fileWriter;

  @override
  Future<WellnessExportBundle> buildExportBundle() async {
    final profile = await profileRepository.getProfile();
    final periods = await periodRepository.getPeriodHistory();
    final logs = await dailyLogRepository.getDailyLogs();
    final privacy = await privacyRepository.getSettings();
    final reminders = await remindersRepository.getReminders();
    final symptomsPayload =
        await assetLoader.loadMap(WellnessConstants.symptomsMockAsset);
    final reportsPayload =
        await assetLoader.loadMap(WellnessConstants.reportsMockAsset);

    return WellnessExportBundle(
      exportedAt: DateTime.now(),
      version: '1.0',
      profile: profile == null
          ? null
          : WellnessProfileModel.fromEntity(profile).toJson(),
      periods: periods
          .map((e) => PeriodEntryModel.fromEntity(e).toJson())
          .toList(),
      dailyLogs: logs.map((e) => DailyLogModel.fromEntity(e).toJson()).toList(),
      symptoms: symptomsPayload['data'] as Map<String, dynamic>?,
      reports: reportsPayload['data'] as Map<String, dynamic>?,
      reminders: reminders
          .map(
            (r) => {
              'id': r.id,
              'type': r.type.name,
              'enabled': r.isEnabled,
              'reminderTime': r.reminderTime,
              'daysBefore': r.daysBefore,
              'title': r.title,
              'hideSensitiveText': r.hideSensitiveText,
            },
          )
          .toList(),
      privacy: privacy == null
          ? null
          : PrivacySettingsModel.fromEntity(privacy).toJson(),
    );
  }

  @override
  Future<ExportFileResult> exportJson(WellnessExportBundle bundle) =>
      fileWriter.writeJson(bundle);

  @override
  Future<ExportFileResult> exportCsv(WellnessExportBundle bundle) =>
      fileWriter.writeCsv(bundle);

  @override
  Future<WellnessExportBundle> importFromJsonFile(String filePath) =>
      fileWriter.readJson(filePath);
}
