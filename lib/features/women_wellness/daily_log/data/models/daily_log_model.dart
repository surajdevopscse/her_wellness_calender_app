import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';

/// JSON model for daily logs.
class DailyLogModel {
  const DailyLogModel({
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

  factory DailyLogModel.fromJson(Map<String, dynamic> json) => DailyLogModel(
    id: json['id'] as String,
    logDate: DateTime.parse(json['logDate'] as String),
    flow: FlowLevel.values.byName(json['flow'] as String),
    painLevel: PainLevel.values.byName(json['painLevel'] as String),
    mood: MoodType.values.byName(json['mood'] as String),
    symptoms: (json['symptoms'] as List<dynamic>? ?? const [])
        .map((value) => SymptomType.values.byName(value as String))
        .toList(),
    energyLevel: EnergyLevel.values.byName(json['energyLevel'] as String),
    sleepQuality: SleepQuality.values.byName(json['sleepQuality'] as String),
    waterIntakeGlass: json['waterIntakeGlass'] as int? ?? 0,
    medicineTaken: json['medicineTaken'] as bool? ?? false,
    medicineName: json['medicineName'] as String?,
    customNotes: json['customNotes'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'logDate': logDate.toIso8601String(),
    'flow': flow.name,
    'painLevel': painLevel.name,
    'mood': mood.name,
    'symptoms': symptoms.map((value) => value.name).toList(),
    'energyLevel': energyLevel.name,
    'sleepQuality': sleepQuality.name,
    'waterIntakeGlass': waterIntakeGlass,
    'medicineTaken': medicineTaken,
    'medicineName': medicineName,
    'customNotes': customNotes,
  };

  DailyLog toEntity() => DailyLog(
    id: id,
    logDate: logDate,
    flow: flow,
    painLevel: painLevel,
    mood: mood,
    symptoms: symptoms,
    energyLevel: energyLevel,
    sleepQuality: sleepQuality,
    waterIntakeGlass: waterIntakeGlass,
    medicineTaken: medicineTaken,
    medicineName: medicineName,
    customNotes: customNotes,
  );

  factory DailyLogModel.fromEntity(DailyLog entity) => DailyLogModel(
    id: entity.id,
    logDate: entity.logDate,
    flow: entity.flow,
    painLevel: entity.painLevel,
    mood: entity.mood,
    symptoms: entity.symptoms,
    energyLevel: entity.energyLevel,
    sleepQuality: entity.sleepQuality,
    waterIntakeGlass: entity.waterIntakeGlass,
    medicineTaken: entity.medicineTaken,
    medicineName: entity.medicineName,
    customNotes: entity.customNotes,
  );
}
