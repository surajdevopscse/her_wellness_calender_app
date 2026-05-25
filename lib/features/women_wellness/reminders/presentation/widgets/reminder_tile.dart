import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';

/// Reminder tile with privacy-aware message.
class ReminderTile extends StatelessWidget {
  const ReminderTile({
    super.key,
    required this.reminder,
    required this.onToggle,
  });

  final WellnessReminder reminder;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: reminder.isEnabled,
      onChanged: onToggle,
      secondary: Icon(reminder.type.icon),
      title: Text(
        reminder.hideSensitiveText
            ? WellnessConstants.privateNotificationTitle
            : reminder.title,
      ),
      subtitle: Text(
        reminder.hideSensitiveText
            ? WellnessConstants.privateNotificationBody
            : reminder.message,
      ),
    );
  }
}
