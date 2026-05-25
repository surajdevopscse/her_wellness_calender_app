import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

enum FlowLevel { none, spotting, light, medium, heavy }

enum PainLevel { none, mild, moderate, severe }

enum MoodType { happy, sad, angry, tired, anxious, emotional }

enum SymptomType {
  cramps,
  headache,
  acne,
  bloating,
  backPain,
  nausea,
  breastTenderness,
}

enum EnergyLevel { low, normal, high }

enum SleepQuality { poor, average, good, excellent }

enum ReminderType {
  upcomingPeriod,
  ovulation,
  dailyLog,
  medicine,
  hydration,
  appointment,
}

enum WellnessCalendarDayType {
  normal,
  confirmedPeriod,
  predictedPeriod,
  ovulation,
  fertileWindow,
  pms,
  logged,
}

extension FlowLevelX on FlowLevel {
  String get label => switch (this) {
    FlowLevel.none => WellnessConstants.none,
    FlowLevel.spotting => WellnessConstants.spotting,
    FlowLevel.light => WellnessConstants.light,
    FlowLevel.medium => WellnessConstants.medium,
    FlowLevel.heavy => WellnessConstants.heavy,
  };
  IconData get icon => Icons.water_drop_outlined;
  Color get color => switch (this) {
    FlowLevel.none => WellnessColors.textSecondary,
    FlowLevel.spotting => WellnessColors.predicted,
    FlowLevel.light => WellnessColors.primary,
    FlowLevel.medium => WellnessColors.period,
    FlowLevel.heavy => WellnessColors.error,
  };
  String get description => '${WellnessConstants.flowLevelPrefix}: $label';
}

extension PainLevelX on PainLevel {
  String get label => switch (this) {
    PainLevel.none => WellnessConstants.none,
    PainLevel.mild => WellnessConstants.mild,
    PainLevel.moderate => WellnessConstants.moderate,
    PainLevel.severe => WellnessConstants.severe,
  };
  IconData get icon => Icons.healing_outlined;
  Color get color => switch (this) {
    PainLevel.none => WellnessColors.success,
    PainLevel.mild => WellnessColors.warning,
    PainLevel.moderate => WellnessColors.ovulation,
    PainLevel.severe => WellnessColors.error,
  };
  String get description => '${WellnessConstants.painLevelPrefix}: $label';
}

extension MoodTypeX on MoodType {
  String get label => switch (this) {
    MoodType.happy => WellnessConstants.happy,
    MoodType.sad => WellnessConstants.sad,
    MoodType.angry => WellnessConstants.angry,
    MoodType.tired => WellnessConstants.tired,
    MoodType.anxious => WellnessConstants.anxious,
    MoodType.emotional => WellnessConstants.emotional,
  };
  IconData get icon => switch (this) {
    MoodType.happy => Icons.sentiment_satisfied_alt,
    MoodType.sad => Icons.sentiment_dissatisfied,
    MoodType.angry => Icons.mood_bad,
    MoodType.tired => Icons.bedtime_outlined,
    MoodType.anxious => Icons.psychology_alt_outlined,
    MoodType.emotional => Icons.favorite_border,
  };
  Color get color => WellnessColors.secondary;
  String get description => '${WellnessConstants.moodPrefix}: $label';
}

extension SymptomTypeX on SymptomType {
  String get label => switch (this) {
    SymptomType.cramps => WellnessConstants.cramps,
    SymptomType.headache => WellnessConstants.headache,
    SymptomType.acne => WellnessConstants.acne,
    SymptomType.bloating => WellnessConstants.bloating,
    SymptomType.backPain => WellnessConstants.backPain,
    SymptomType.nausea => WellnessConstants.nausea,
    SymptomType.breastTenderness => WellnessConstants.breastTenderness,
  };
  IconData get icon => Icons.spa_outlined;
  Color get color => WellnessColors.primary;
  String get description => '${WellnessConstants.symptomPrefix}: $label';
}

extension EnergyLevelX on EnergyLevel {
  String get label => switch (this) {
    EnergyLevel.low => WellnessConstants.low,
    EnergyLevel.normal => WellnessConstants.normal,
    EnergyLevel.high => WellnessConstants.high,
  };
  IconData get icon => Icons.bolt_outlined;
  Color get color => switch (this) {
    EnergyLevel.low => WellnessColors.warning,
    EnergyLevel.normal => WellnessColors.secondary,
    EnergyLevel.high => WellnessColors.success,
  };
  String get description => '${WellnessConstants.energyLevelPrefix}: $label';
}

extension SleepQualityX on SleepQuality {
  String get label => switch (this) {
    SleepQuality.poor => WellnessConstants.poor,
    SleepQuality.average => WellnessConstants.average,
    SleepQuality.good => WellnessConstants.good,
    SleepQuality.excellent => WellnessConstants.excellent,
  };
  IconData get icon => Icons.nightlight_outlined;
  Color get color => WellnessColors.secondary;
  String get description => '${WellnessConstants.sleepQualityPrefix}: $label';
}

extension ReminderTypeX on ReminderType {
  String get label => switch (this) {
    ReminderType.upcomingPeriod => WellnessConstants.upcomingPeriod,
    ReminderType.ovulation => WellnessConstants.ovulation,
    ReminderType.dailyLog => WellnessConstants.dailyLog,
    ReminderType.medicine => WellnessConstants.medicine,
    ReminderType.hydration => WellnessConstants.hydration,
    ReminderType.appointment => WellnessConstants.appointment,
  };
  IconData get icon => switch (this) {
    ReminderType.upcomingPeriod => Icons.event_available_outlined,
    ReminderType.ovulation => Icons.egg_alt_outlined,
    ReminderType.dailyLog => Icons.today_outlined,
    ReminderType.medicine => Icons.medication_outlined,
    ReminderType.hydration => Icons.water_drop_outlined,
    ReminderType.appointment => Icons.calendar_month_outlined,
  };
  Color get color => WellnessColors.primary;
  String get description => '$label ${WellnessConstants.reminderSuffix}';
}

extension WellnessCalendarDayTypeX on WellnessCalendarDayType {
  String get label => switch (this) {
    WellnessCalendarDayType.normal => WellnessConstants.normal,
    WellnessCalendarDayType.confirmedPeriod =>
      WellnessConstants.confirmedPeriod,
    WellnessCalendarDayType.predictedPeriod =>
      WellnessConstants.predictedPeriod,
    WellnessCalendarDayType.ovulation => WellnessConstants.ovulation,
    WellnessCalendarDayType.fertileWindow => WellnessConstants.fertileWindow,
    WellnessCalendarDayType.pms => WellnessConstants.pms,
    WellnessCalendarDayType.logged => WellnessConstants.logged,
  };

  IconData get icon => switch (this) {
    WellnessCalendarDayType.normal => Icons.calendar_today_outlined,
    WellnessCalendarDayType.confirmedPeriod => Icons.water_drop,
    WellnessCalendarDayType.predictedPeriod => Icons.water_drop_outlined,
    WellnessCalendarDayType.ovulation => Icons.egg_alt_outlined,
    WellnessCalendarDayType.fertileWindow => Icons.eco_outlined,
    WellnessCalendarDayType.pms => Icons.cloud_outlined,
    WellnessCalendarDayType.logged => Icons.check_circle_outline,
  };

  Color get color => switch (this) {
    WellnessCalendarDayType.normal => WellnessColors.textSecondary,
    WellnessCalendarDayType.confirmedPeriod => WellnessColors.period,
    WellnessCalendarDayType.predictedPeriod => WellnessColors.predicted,
    WellnessCalendarDayType.ovulation => WellnessColors.ovulation,
    WellnessCalendarDayType.fertileWindow => WellnessColors.fertile,
    WellnessCalendarDayType.pms => WellnessColors.pms,
    WellnessCalendarDayType.logged => WellnessColors.success,
  };

  String get description => label;
}
