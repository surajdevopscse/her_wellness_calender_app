import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';

/// Data transfer model for symptom API and JSON mock payloads.
class SymptomItemModel {
  const SymptomItemModel({
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

  factory SymptomItemModel.fromJson(Map<String, dynamic> json) {
    final typeName = json['type'] as String?;
    return SymptomItemModel(
      id: json['id'] as String,
      label: json['label'] as String,
      type: typeName == null ? null : SymptomType.values.byName(typeName),
      isRecentlyUsed: json['isRecentlyUsed'] as bool? ?? false,
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'type': type?.name,
    'isRecentlyUsed': isRecentlyUsed,
    'isCustom': isCustom,
  };

  SymptomItem toEntity() => SymptomItem(
    id: id,
    label: label,
    type: type,
    isRecentlyUsed: isRecentlyUsed,
    isCustom: isCustom,
  );

  factory SymptomItemModel.fromEntity(SymptomItem entity) => SymptomItemModel(
    id: entity.id,
    label: entity.label,
    type: entity.type,
    isRecentlyUsed: entity.isRecentlyUsed,
    isCustom: entity.isCustom,
  );
}
