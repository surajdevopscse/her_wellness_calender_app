import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/repositories/reminders_repository.dart';

/// Loads reminder settings.
class GetRemindersUseCase {
  const GetRemindersUseCase(this.repository);

  final RemindersRepository repository;

  Future<List<WellnessReminder>> call() => repository.getReminders();
}
