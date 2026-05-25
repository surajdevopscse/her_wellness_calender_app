/// Domain entity for one menstrual period entry.
class PeriodEntry {
  const PeriodEntry({
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

  /// Derived inclusive period length in days.
  int get periodLength =>
      endDate == null ? 1 : endDate!.difference(startDate).inDays + 1;

  /// Returns an updated entry while preserving unchanged values.
  PeriodEntry copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    bool? isPredicted,
    bool? isConfirmed,
    String? irregularCycleNote,
    String? notes,
  }) {
    return PeriodEntry(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isPredicted: isPredicted ?? this.isPredicted,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      irregularCycleNote: irregularCycleNote ?? this.irregularCycleNote,
      notes: notes ?? this.notes,
    );
  }
}
