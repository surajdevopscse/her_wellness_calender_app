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
import 'package:her_wellness_calender/features/women_wellness/reminders/data/models/reminder_model.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/repositories/reminders_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/data/models/symptom_item_model.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/repositories/symptoms_repository.dart';

class DataExportRepositoryImpl implements DataExportRepository {
  DataExportRepositoryImpl({
    required this.profileRepository,
    required this.periodRepository,
    required this.dailyLogRepository,
    required this.privacyRepository,
    required this.remindersRepository,
    required this.symptomsRepository,
    required this.reportsRepository,
    required this.fileWriter,
  });

  final WellnessProfileRepository profileRepository;
  final PeriodTrackingRepository periodRepository;
  final DailyLogRepository dailyLogRepository;
  final PrivacyRepository privacyRepository;
  final RemindersRepository remindersRepository;
  final SymptomsRepository symptomsRepository;
  final ReportsRepository reportsRepository;
  final WellnessExportFileWriter fileWriter;

  @override
  Future<WellnessExportBundle> buildExportBundle() async {
    final profile = await profileRepository.getProfile();
    final periods = await periodRepository.getPeriodHistory();
    final logs = await dailyLogRepository.getDailyLogs();
    final privacy = await privacyRepository.getSettings();
    final reminders = await remindersRepository.getReminders();
    final symptoms = await symptomsRepository.getSymptoms();
    final report = await reportsRepository.getReports();

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
      symptoms: symptoms
          .map((item) => SymptomItemModel.fromEntity(item).toJson())
          .toList(),
      reports: {
        'averageCycleLength': report.averageCycleLength,
        'averagePeriodLength': report.averagePeriodLength,
        'cycleRegularity': report.cycleRegularity,
        'cycleLengthTrend': report.cycleLengthTrend,
        'symptomFrequency': report.symptomFrequency,
        'moodDistribution': report.moodDistribution,
        'painTrend': report.painTrend,
        'flowTrend': report.flowTrend,
        'commonSymptoms': report.commonSymptoms,
        'pmsPattern': report.pmsPattern,
        'hasLatePeriodAlert': report.hasLatePeriodAlert,
        'monthlySummary': report.monthlySummary,
        'yearlySummary': report.yearlySummary,
        'notes': report.notes,
      },
      reminders: reminders
          .map((item) => ReminderModel.fromEntity(item).toJson())
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

  @override
  Future<void> restoreFromBundle(WellnessExportBundle bundle) async {
    if (bundle.profile != null) {
      final profile = WellnessProfileModel.fromJson(bundle.profile!).toEntity();
      await profileRepository.updateProfile(profile);
    }

    if (bundle.privacy != null) {
      final privacy =
          PrivacySettingsModel.fromJson(bundle.privacy!).toEntity();
      await privacyRepository.updateSettings(privacy);
    }

    if (bundle.symptoms.isNotEmpty) {
      final symptoms = bundle.symptoms
          .map((item) => SymptomItemModel.fromJson(item).toEntity())
          .toList();
      await symptomsRepository.saveSelectedSymptoms(symptoms);
    }

    final existingReminders = await remindersRepository.getReminders();
    final remindersByType = {
      for (final reminder in existingReminders) reminder.type: reminder,
    };
    for (final item in bundle.reminders) {
      final reminder = ReminderModel.fromJson(item).toEntity();
      final current = remindersByType[reminder.type];
      if (current != null) {
        await remindersRepository.updateReminder(
          current.copyWith(
            isEnabled: reminder.isEnabled,
            reminderTime: reminder.reminderTime,
            daysBefore: reminder.daysBefore,
            hideSensitiveText: reminder.hideSensitiveText,
          ),
        );
      }
    }

    await _restorePeriods(bundle);
    await _restoreDailyLogs(bundle);
  }

  Future<void> _restorePeriods(WellnessExportBundle bundle) async {
    final existing = await periodRepository.getPeriodHistory();
    final existingById = {for (final item in existing) item.id: item};
    final incomingIds = <String>{};

    for (final item in bundle.periods) {
      final period = PeriodEntryModel.fromJson(item).toEntity();
      incomingIds.add(period.id);
      if (existingById.containsKey(period.id)) {
        await periodRepository.updatePeriodEntry(period);
      } else {
        await periodRepository.addPeriodEntry(period);
      }
    }

    for (final item in existing) {
      if (!incomingIds.contains(item.id)) {
        await periodRepository.deletePeriodEntry(item.id);
      }
    }
  }

  Future<void> _restoreDailyLogs(WellnessExportBundle bundle) async {
    final existing = await dailyLogRepository.getDailyLogs();
    final existingById = {for (final item in existing) item.id: item};
    final incomingIds = <String>{};

    for (final item in bundle.dailyLogs) {
      final log = DailyLogModel.fromJson(item).toEntity();
      incomingIds.add(log.id);
      if (existingById.containsKey(log.id)) {
        await dailyLogRepository.updateDailyLog(log);
      } else {
        await dailyLogRepository.addDailyLog(log);
      }
    }

    for (final item in existing) {
      if (!incomingIds.contains(item.id)) {
        await dailyLogRepository.deleteDailyLog(item.id);
      }
    }
  }
}
