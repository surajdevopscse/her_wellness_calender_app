import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';

/// Contract for symptom catalog and selected symptom persistence.
abstract class SymptomsRepository {
  /// Loads available symptoms.
  Future<List<SymptomItem>> getSymptoms();

  /// Persists selected symptom ids for the current workflow/user.
  Future<List<SymptomItem>> saveSelectedSymptoms(List<SymptomItem> symptoms);
}
