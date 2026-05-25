import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';

/// Reminder settings for wellness notifications.
class WellnessReminder {
  const WellnessReminder({
    required this.id,
    required this.type,
    required this.isEnabled,
    required this.reminderTime,
    required this.daysBefore,
    required this.title,
    required this.message,
    required this.hideSensitiveText,
  });

  final String id;
  final ReminderType type;
  final String reminderTime;
  final bool isEnabled;
  final int daysBefore;
  final String title;
  final String message;
  final bool hideSensitiveText;

  WellnessReminder copyWith({
    bool? isEnabled,
    String? reminderTime,
    int? daysBefore,
    bool? hideSensitiveText,
  }) {
    return WellnessReminder(
      id: id,
      type: type,
      isEnabled: isEnabled ?? this.isEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      daysBefore: daysBefore ?? this.daysBefore,
      title: title,
      message: message,
      hideSensitiveText: hideSensitiveText ?? this.hideSensitiveText,
    );
  }
}
