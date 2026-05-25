import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/data/models/privacy_settings_model.dart';

/// Data transfer model for profile API and mock JSON payloads.
class WellnessProfileModel {
  const WellnessProfileModel({
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
  final PrivacySettingsModel privacySettings;

  factory WellnessProfileModel.fromJson(Map<String, dynamic> json) =>
      WellnessProfileModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        ageGroup: json['ageGroup'] as String?,
        averageCycleLength: json['averageCycleLength'] as int,
        averagePeriodLength: json['averagePeriodLength'] as int,
        lastPeriodStartDate: DateTime.parse(
          json['lastPeriodStartDate'] as String,
        ),
        healthNotes: json['healthNotes'] as String?,
        privacySettings: PrivacySettingsModel.fromJson(
          json['privacySettings'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'ageGroup': ageGroup,
    'averageCycleLength': averageCycleLength,
    'averagePeriodLength': averagePeriodLength,
    'lastPeriodStartDate': lastPeriodStartDate.toIso8601String(),
    'healthNotes': healthNotes,
    'privacySettings': privacySettings.toJson(),
  };

  WellnessProfile toEntity() => WellnessProfile(
    id: id,
    userId: userId,
    ageGroup: ageGroup,
    averageCycleLength: averageCycleLength,
    averagePeriodLength: averagePeriodLength,
    lastPeriodStartDate: lastPeriodStartDate,
    healthNotes: healthNotes,
    privacySettings: privacySettings.toEntity(),
  );

  /// Builds a JSON model from the domain entity for update requests.
  factory WellnessProfileModel.fromEntity(WellnessProfile entity) {
    return WellnessProfileModel(
      id: entity.id,
      userId: entity.userId,
      ageGroup: entity.ageGroup,
      averageCycleLength: entity.averageCycleLength,
      averagePeriodLength: entity.averagePeriodLength,
      lastPeriodStartDate: entity.lastPeriodStartDate,
      healthNotes: entity.healthNotes,
      privacySettings: PrivacySettingsModel.fromEntity(entity.privacySettings),
    );
  }
}
