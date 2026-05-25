import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';

/// Repository contract for wellness reminders.
abstract class RemindersRepository {
  Future<List<WellnessReminder>> getReminders();
  Future<void> updateReminder(WellnessReminder reminder);
}
