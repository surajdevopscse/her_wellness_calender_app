import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/repositories/reminders_repository.dart';

/// Updates reminder settings.
class UpdateReminderUseCase {
  const UpdateReminderUseCase(this.repository);

  final RemindersRepository repository;

  Future<void> call(WellnessReminder reminder) =>
      repository.updateReminder(reminder);
}
