enum AppThemeMode { system, light, dark }

class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.notificationsEnabled,
    required this.languageCode,
  });

  final AppThemeMode themeMode;
  final bool notificationsEnabled;
  final String languageCode;

  AppSettings copyWith({
    AppThemeMode? themeMode,
    bool? notificationsEnabled,
    String? languageCode,
  }) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        languageCode: languageCode ?? this.languageCode,
      );
}
