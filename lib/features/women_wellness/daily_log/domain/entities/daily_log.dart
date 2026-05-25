import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';

/// Domain entity for a single day of wellness tracking.
class DailyLog {
  const DailyLog({
    required this.id,
    required this.logDate,
    required this.flow,
    required this.painLevel,
    required this.mood,
    required this.symptoms,
    required this.energyLevel,
    required this.sleepQuality,
    required this.waterIntakeGlass,
    required this.medicineTaken,
    this.medicineName,
    this.customNotes,
  });

  final String id;
  final DateTime logDate;
  final FlowLevel flow;
  final PainLevel painLevel;
  final MoodType mood;
  final List<SymptomType> symptoms;
  final EnergyLevel energyLevel;
  final SleepQuality sleepQuality;
  final int waterIntakeGlass;
  final bool medicineTaken;
  final String? medicineName;
  final String? customNotes;

  /// Returns an updated log while preserving unchanged values.
  DailyLog copyWith({
    String? id,
    DateTime? logDate,
    FlowLevel? flow,
    PainLevel? painLevel,
    MoodType? mood,
    List<SymptomType>? symptoms,
    EnergyLevel? energyLevel,
    SleepQuality? sleepQuality,
    int? waterIntakeGlass,
    bool? medicineTaken,
    String? medicineName,
    String? customNotes,
  }) {
    return DailyLog(
      id: id ?? this.id,
      logDate: logDate ?? this.logDate,
      flow: flow ?? this.flow,
      painLevel: painLevel ?? this.painLevel,
      mood: mood ?? this.mood,
      symptoms: symptoms ?? this.symptoms,
      energyLevel: energyLevel ?? this.energyLevel,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      waterIntakeGlass: waterIntakeGlass ?? this.waterIntakeGlass,
      medicineTaken: medicineTaken ?? this.medicineTaken,
      medicineName: medicineName ?? this.medicineName,
      customNotes: customNotes ?? this.customNotes,
    );
  }
}
