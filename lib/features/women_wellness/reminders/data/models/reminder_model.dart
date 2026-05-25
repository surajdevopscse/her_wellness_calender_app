import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';
import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';

/// JSON model for reminder settings.
class ReminderModel {
  const ReminderModel({
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
  final bool isEnabled;
  final String reminderTime;
  final int daysBefore;
  final String title;
  final String message;
  final bool hideSensitiveText;

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
    id: json['id'] as String,
    type: ReminderType.values.byName(json['type'] as String),
    isEnabled: json['isEnabled'] as bool? ?? true,
    reminderTime: json['reminderTime'] as String,
    daysBefore: json['daysBefore'] as int? ?? 0,
    title: json['title'] as String,
    message: json['message'] as String,
    hideSensitiveText: json['hideSensitiveText'] as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'isEnabled': isEnabled,
    'reminderTime': reminderTime,
    'daysBefore': daysBefore,
    'title': title,
    'message': message,
    'hideSensitiveText': hideSensitiveText,
  };

  WellnessReminder toEntity() => WellnessReminder(
    id: id,
    type: type,
    isEnabled: isEnabled,
    reminderTime: reminderTime,
    daysBefore: daysBefore,
    title: title,
    message: message,
    hideSensitiveText: hideSensitiveText,
  );

  factory ReminderModel.fromEntity(WellnessReminder entity) => ReminderModel(
    id: entity.id,
    type: entity.type,
    isEnabled: entity.isEnabled,
    reminderTime: entity.reminderTime,
    daysBefore: entity.daysBefore,
    title: entity.title,
    message: entity.message,
    hideSensitiveText: entity.hideSensitiveText,
  );
}
