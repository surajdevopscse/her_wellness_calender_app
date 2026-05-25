import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/repositories/symptoms_repository.dart';

/// Use case for saving the selected symptom set.
class SaveSelectedSymptomsUseCase {
  const SaveSelectedSymptomsUseCase(this.repository);

  final SymptomsRepository repository;

  Future<List<SymptomItem>> call(List<SymptomItem> symptoms) {
    return repository.saveSelectedSymptoms(symptoms);
  }
}
