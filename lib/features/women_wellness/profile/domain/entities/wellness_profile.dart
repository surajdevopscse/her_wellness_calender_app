import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';

/// Business entity containing the user's wellness profile baseline.
///
/// The privacy settings relation is preserved for existing wellness flows that
/// already read privacy data through the profile payload.
/// Profile settings used for predictions and privacy controls.
class WellnessProfile {
  const WellnessProfile({
    required this.id,
    required this.userId,
    this.ageGroup,
    required this.averageCycleLength,
    required this.averagePeriodLength,
    required this.lastPeriodStartDate,
    this.healthNotes,
    required this.privacySettings,
  });

  final String id;
  final String userId;
  final String? ageGroup;
  final int averageCycleLength;
  final int averagePeriodLength;
  final DateTime lastPeriodStartDate;
  final String? healthNotes;
  final PrivacySettings privacySettings;

  /// Returns an updated profile while preserving unchanged fields.
  WellnessProfile copyWith({
    String? id,
    String? userId,
    String? ageGroup,
    int? averageCycleLength,
    int? averagePeriodLength,
    DateTime? lastPeriodStartDate,
    String? healthNotes,
    PrivacySettings? privacySettings,
  }) {
    return WellnessProfile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ageGroup: ageGroup ?? this.ageGroup,
      averageCycleLength: averageCycleLength ?? this.averageCycleLength,
      averagePeriodLength: averagePeriodLength ?? this.averagePeriodLength,
      lastPeriodStartDate: lastPeriodStartDate ?? this.lastPeriodStartDate,
      healthNotes: healthNotes ?? this.healthNotes,
      privacySettings: privacySettings ?? this.privacySettings,
    );
  }
}
