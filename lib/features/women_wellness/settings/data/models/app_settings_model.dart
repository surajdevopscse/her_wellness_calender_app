import 'package:her_wellness_calender/features/women_wellness/settings/domain/entities/app_settings.dart';

class AppSettingsModel {
  const AppSettingsModel({
    required this.themeMode,
    required this.notificationsEnabled,
    required this.languageCode,
  });

  final String themeMode;
  final bool notificationsEnabled;
  final String languageCode;

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      themeMode: json['themeMode'] as String? ?? 'system',
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      languageCode: json['languageCode'] as String? ?? 'en',
    );
  }

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode,
        'notificationsEnabled': notificationsEnabled,
        'languageCode': languageCode,
      };

  AppSettings toEntity() => AppSettings(
        themeMode: switch (themeMode) {
          'light' => AppThemeMode.light,
          'dark' => AppThemeMode.dark,
          _ => AppThemeMode.system,
        },
        notificationsEnabled: notificationsEnabled,
        languageCode: languageCode,
      );

  static AppSettingsModel fromEntity(AppSettings entity) => AppSettingsModel(
        themeMode: switch (entity.themeMode) {
          AppThemeMode.light => 'light',
          AppThemeMode.dark => 'dark',
          AppThemeMode.system => 'system',
        },
        notificationsEnabled: entity.notificationsEnabled,
        languageCode: entity.languageCode,
      );
}
