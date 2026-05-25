/// Domain entity for privacy and security preferences.
class PrivacySettings {
  const PrivacySettings({
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

  /// Backward-compatible alias for existing profile/wellness integrations.
  bool get hideSensitiveNotificationText => hideNotificationText;

  /// Backward-compatible alias for existing profile/wellness integrations.
  bool get encryptedLocalStorageEnabled => encryptedStorageEnabled;

  /// Backward-compatible alias for existing profile/wellness integrations.
  bool get cloudBackupAllowed => allowCloudBackup;

  /// Returns an updated settings object while preserving unchanged fields.
  PrivacySettings copyWith({
    bool? appLockEnabled,
    bool? pinEnabled,
    bool? biometricEnabled,
    bool? hideNotificationText,
    bool? encryptedStorageEnabled,
    bool? allowCloudBackup,
    bool? hideSensitiveNotificationText,
    bool? encryptedLocalStorageEnabled,
    bool? cloudBackupAllowed,
  }) {
    return PrivacySettings(
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      hideNotificationText:
          hideNotificationText ??
          hideSensitiveNotificationText ??
          this.hideNotificationText,
      encryptedStorageEnabled:
          encryptedStorageEnabled ??
          encryptedLocalStorageEnabled ??
          this.encryptedStorageEnabled,
      allowCloudBackup:
          allowCloudBackup ?? cloudBackupAllowed ?? this.allowCloudBackup,
    );
  }
}
