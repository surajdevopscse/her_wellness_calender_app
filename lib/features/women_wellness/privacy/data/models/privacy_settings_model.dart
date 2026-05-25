import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';

/// Data transfer model for privacy API and JSON mock payloads.
class PrivacySettingsModel {
  const PrivacySettingsModel({
    required this.appLockEnabled,
    required this.pinEnabled,
    required this.biometricEnabled,
    required this.hideNotificationText,
    required this.encryptedStorageEnabled,
    required this.allowCloudBackup,
  });

  final bool appLockEnabled;
  final bool pinEnabled;
  final bool biometricEnabled;
  final bool hideNotificationText;
  final bool encryptedStorageEnabled;
  final bool allowCloudBackup;

  factory PrivacySettingsModel.fromJson(Map<String, dynamic> json) {
    return PrivacySettingsModel(
      appLockEnabled: json['appLockEnabled'] as bool? ?? false,
      pinEnabled: json['pinEnabled'] as bool? ?? false,
      biometricEnabled: json['biometricEnabled'] as bool? ?? false,
      hideNotificationText:
          json['hideNotificationText'] as bool? ??
          json['hideSensitiveNotificationText'] as bool? ??
          true,
      encryptedStorageEnabled:
          json['encryptedStorageEnabled'] as bool? ??
          json['encryptedLocalStorageEnabled'] as bool? ??
          true,
      allowCloudBackup:
          json['allowCloudBackup'] as bool? ??
          json['cloudBackupAllowed'] as bool? ??
          false,
    );
  }

  Map<String, dynamic> toJson() => {
    'appLockEnabled': appLockEnabled,
    'pinEnabled': pinEnabled,
    'biometricEnabled': biometricEnabled,
    'hideNotificationText': hideNotificationText,
    'encryptedStorageEnabled': encryptedStorageEnabled,
    'allowCloudBackup': allowCloudBackup,
  };

  /// Legacy JSON shape for existing combined wellness mock/profile payloads.
  Map<String, dynamic> toLegacyJson() => {
    'appLockEnabled': appLockEnabled,
    'pinEnabled': pinEnabled,
    'biometricEnabled': biometricEnabled,
    'hideSensitiveNotificationText': hideNotificationText,
    'encryptedLocalStorageEnabled': encryptedStorageEnabled,
    'cloudBackupAllowed': allowCloudBackup,
  };

  PrivacySettings toEntity() => PrivacySettings(
    appLockEnabled: appLockEnabled,
    pinEnabled: pinEnabled,
    biometricEnabled: biometricEnabled,
    hideNotificationText: hideNotificationText,
    encryptedStorageEnabled: encryptedStorageEnabled,
    allowCloudBackup: allowCloudBackup,
  );

  factory PrivacySettingsModel.fromEntity(PrivacySettings entity) =>
      PrivacySettingsModel(
        appLockEnabled: entity.appLockEnabled,
        pinEnabled: entity.pinEnabled,
        biometricEnabled: entity.biometricEnabled,
        hideNotificationText: entity.hideNotificationText,
        encryptedStorageEnabled: entity.encryptedStorageEnabled,
        allowCloudBackup: entity.allowCloudBackup,
      );
}
