import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';

/// JSON model for wellness reports.
class WellnessReportModel {
  const WellnessReportModel({
    required this.averageCycleLength,
    required this.averagePeriodLength,
    required this.cycleRegularity,
    required this.cycleLengthTrend,
    required this.symptomFrequency,
    required this.moodDistribution,
    required this.painTrend,
    required this.flowTrend,
    required this.commonSymptoms,
    required this.pmsPattern,
    required this.hasLatePeriodAlert,
    required this.monthlySummary,
    required this.yearlySummary,
    required this.notes,
  });

  final double averageCycleLength;
  final double averagePeriodLength;
  final String cycleRegularity;
  final List<int> cycleLengthTrend;
  final Map<String, int> symptomFrequency;
  final Map<String, int> moodDistribution;
  final Map<String, int> painTrend;
  final Map<String, int> flowTrend;
  final List<String> commonSymptoms;
  final String pmsPattern;
  final bool hasLatePeriodAlert;
  final String monthlySummary;
  final String yearlySummary;
  final String notes;

  factory WellnessReportModel.fromJson(
    Map<String, dynamic> json,
  ) => WellnessReportModel(
    averageCycleLength: (json['averageCycleLength'] as num).toDouble(),
    averagePeriodLength: (json['averagePeriodLength'] as num).toDouble(),
    cycleRegularity: json['cycleRegularity'] as String,
    cycleLengthTrend: List<int>.from(json['cycleLengthTrend'] as List<dynamic>),
    symptomFrequency: Map<String, int>.from(
      json['symptomFrequency'] as Map<String, dynamic>,
    ),
    moodDistribution: Map<String, int>.from(
      json['moodDistribution'] as Map<String, dynamic>,
    ),
    painTrend: Map<String, int>.from(json['painTrend'] as Map<String, dynamic>),
    flowTrend: Map<String, int>.from(json['flowTrend'] as Map<String, dynamic>),
    commonSymptoms: List<String>.from(json['commonSymptoms'] as List<dynamic>),
    pmsPattern: json['pmsPattern'] as String,
    hasLatePeriodAlert: json['hasLatePeriodAlert'] as bool? ?? false,
    monthlySummary: json['monthlySummary'] as String,
    yearlySummary: json['yearlySummary'] as String,
    notes: json['notes'] as String,
  );

  WellnessReport toEntity() => WellnessReport(
    averageCycleLength: averageCycleLength,
    averagePeriodLength: averagePeriodLength,
    cycleRegularity: cycleRegularity,
    cycleLengthTrend: cycleLengthTrend,
    symptomFrequency: symptomFrequency,
    moodDistribution: moodDistribution,
    painTrend: painTrend,
    flowTrend: flowTrend,
    commonSymptoms: commonSymptoms,
    pmsPattern: pmsPattern,
    hasLatePeriodAlert: hasLatePeriodAlert,
    monthlySummary: monthlySummary,
    yearlySummary: yearlySummary,
    notes: notes,
  );
}
