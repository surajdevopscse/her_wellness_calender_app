import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/data/datasources/symptoms_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/data/datasources/symptoms_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/data/models/symptom_item_model.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/repositories/symptoms_repository.dart';

/// Repository implementation that switches between mock and remote symptom APIs.
class SymptomsRepositoryImpl implements SymptomsRepository {
  const SymptomsRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final SymptomsMockDatasource mockDatasource;
  final SymptomsRemoteDatasource remoteDatasource;

  @override
  Future<List<SymptomItem>> getSymptoms() async {
    final response = environment.isMockMode
        ? await mockDatasource.getSymptoms()
        : await remoteDatasource.getSymptoms();
    final data = response['data'] as List<dynamic>? ?? const [];
    return data
        .map(
          (item) => SymptomItemModel.fromJson(
            item as Map<String, dynamic>,
          ).toEntity(),
        )
        .toList();
  }

  @override
  Future<List<SymptomItem>> saveSelectedSymptoms(
    List<SymptomItem> symptoms,
  ) async {
    final payload = symptoms
        .map((item) => SymptomItemModel.fromEntity(item).toJson())
        .toList();
    final response = environment.isMockMode
        ? await mockDatasource.saveSelectedSymptoms(payload)
        : await remoteDatasource.saveSelectedSymptoms(payload);
    final data = response['data'] as List<dynamic>? ?? const [];
    return data
        .map(
          (item) => SymptomItemModel.fromJson(
            item as Map<String, dynamic>,
          ).toEntity(),
        )
        .toList();
  }
}
