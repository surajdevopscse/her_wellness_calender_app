import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/repositories/symptoms_repository.dart';

/// Use case for loading symptom catalog items.
class GetSymptomsUseCase {
  const GetSymptomsUseCase(this.repository);

  final SymptomsRepository repository;

  Future<List<SymptomItem>> call() => repository.getSymptoms();
}
