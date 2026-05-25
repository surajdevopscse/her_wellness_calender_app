import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/data/datasources/reminders_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/data/datasources/reminders_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/data/models/reminder_model.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/repositories/reminders_repository.dart';

/// Repository implementation that switches between mock and remote reminders.
class RemindersRepositoryImpl implements RemindersRepository {
  const RemindersRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final RemindersMockDatasource mockDatasource;
  final RemindersRemoteDatasource remoteDatasource;

  @override
  Future<List<WellnessReminder>> getReminders() async {
    final response = environment.isMockMode
        ? await mockDatasource.getReminders()
        : await remoteDatasource.getReminders();
    final data = response['data'] as List<dynamic>? ?? const [];
    return data
        .map((item) => ReminderModel.fromJson(item as Map<String, dynamic>))
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<void> updateReminder(WellnessReminder reminder) async {
    final payload = ReminderModel.fromEntity(reminder).toJson();
    if (environment.isMockMode) {
      await mockDatasource.updateReminder(payload);
    } else {
      await remoteDatasource.updateReminder(payload);
    }
  }
}
