import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';

/// Domain entity for selectable wellness symptoms.
class SymptomItem {
  const SymptomItem({
    required this.id,
    required this.label,
    this.type,
    this.isRecentlyUsed = false,
    this.isCustom = false,
  });

  final String id;
  final String label;
  final SymptomType? type;
  final bool isRecentlyUsed;
  final bool isCustom;

  /// Returns an updated symptom item while preserving unchanged fields.
  SymptomItem copyWith({
    String? id,
    String? label,
    SymptomType? type,
    bool? isRecentlyUsed,
    bool? isCustom,
  }) {
    return SymptomItem(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      isRecentlyUsed: isRecentlyUsed ?? this.isRecentlyUsed,
      isCustom: isCustom ?? this.isCustom,
    );
  }
}
