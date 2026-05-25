import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';

/// JSON model for prediction estimates.
class CyclePredictionModel {
  const CyclePredictionModel({
    required this.nextPeriodDate,
    required this.ovulationDate,
    required this.fertileWindowStart,
    required this.fertileWindowEnd,
    required this.pmsStartDate,
    required this.pmsEndDate,
    required this.currentCycleDay,
    required this.daysUntilNextPeriod,
    required this.isLate,
    this.warningMessage,
  });

  final DateTime nextPeriodDate;
  final DateTime ovulationDate;
  final DateTime fertileWindowStart;
  final DateTime fertileWindowEnd;
  final DateTime pmsStartDate;
  final DateTime pmsEndDate;
  final int currentCycleDay;
  final int daysUntilNextPeriod;
  final bool isLate;
  final String? warningMessage;

  factory CyclePredictionModel.fromJson(Map<String, dynamic> json) =>
      CyclePredictionModel(
        nextPeriodDate: DateTime.parse(json['nextPeriodDate'] as String),
        ovulationDate: DateTime.parse(json['ovulationDate'] as String),
        fertileWindowStart: DateTime.parse(
          json['fertileWindowStart'] as String,
        ),
        fertileWindowEnd: DateTime.parse(json['fertileWindowEnd'] as String),
        pmsStartDate: DateTime.parse(json['pmsStartDate'] as String),
        pmsEndDate: DateTime.parse(json['pmsEndDate'] as String),
        currentCycleDay: json['currentCycleDay'] as int,
        daysUntilNextPeriod: json['daysUntilNextPeriod'] as int,
        isLate: json['isLate'] as bool? ?? false,
        warningMessage: json['warningMessage'] as String?,
      );

  CyclePrediction toEntity() => CyclePrediction(
    nextPeriodDate: nextPeriodDate,
    ovulationDate: ovulationDate,
    fertileWindowStart: fertileWindowStart,
    fertileWindowEnd: fertileWindowEnd,
    pmsStartDate: pmsStartDate,
    pmsEndDate: pmsEndDate,
    currentCycleDay: currentCycleDay,
    daysUntilNextPeriod: daysUntilNextPeriod,
    isLate: isLate,
    warningMessage: warningMessage,
  );
}
