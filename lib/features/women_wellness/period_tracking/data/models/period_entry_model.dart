import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';

/// JSON model for period entries.
class PeriodEntryModel {
  const PeriodEntryModel({
    required this.id,
    required this.startDate,
    this.endDate,
    required this.isPredicted,
    required this.isConfirmed,
    this.irregularCycleNote,
    this.notes,
  });

  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isPredicted;
  final bool isConfirmed;
  final String? irregularCycleNote;
  final String? notes;

  factory PeriodEntryModel.fromJson(Map<String, dynamic> json) =>
      PeriodEntryModel(
        id: json['id'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null
            ? null
            : DateTime.parse(json['endDate'] as String),
        isPredicted: json['isPredicted'] as bool? ?? false,
        isConfirmed: json['isConfirmed'] as bool? ?? true,
        irregularCycleNote: json['irregularCycleNote'] as String?,
        notes: json['notes'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'periodLength': endDate == null
        ? 1
        : endDate!.difference(startDate).inDays + 1,
    'isPredicted': isPredicted,
    'isConfirmed': isConfirmed,
    'irregularCycleNote': irregularCycleNote,
    'notes': notes,
  };

  PeriodEntry toEntity() => PeriodEntry(
    id: id,
    startDate: startDate,
    endDate: endDate,
    isPredicted: isPredicted,
    isConfirmed: isConfirmed,
    irregularCycleNote: irregularCycleNote,
    notes: notes,
  );

  factory PeriodEntryModel.fromEntity(PeriodEntry entity) => PeriodEntryModel(
    id: entity.id,
    startDate: entity.startDate,
    endDate: entity.endDate,
    isPredicted: entity.isPredicted,
    isConfirmed: entity.isConfirmed,
    irregularCycleNote: entity.irregularCycleNote,
    notes: entity.notes,
  );
}
