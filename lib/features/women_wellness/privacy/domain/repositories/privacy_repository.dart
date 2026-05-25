import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';

/// Contract for privacy settings and privacy-sensitive delete operations.
abstract class PrivacyRepository {
  /// Loads privacy settings for the current user.
  Future<PrivacySettings?> getSettings();

  /// Saves privacy settings and returns the persisted values.
  Future<PrivacySettings> updateSettings(PrivacySettings settings);

  /// Permanently deletes wellness tracking data.
  Future<void> deleteWellnessData();

  /// Permanently deletes the account and all wellness data.
  Future<void> deleteAccountAndData();
}
