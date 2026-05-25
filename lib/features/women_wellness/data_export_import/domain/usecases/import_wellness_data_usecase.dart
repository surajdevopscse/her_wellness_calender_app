import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/wellness_export_bundle.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/repositories/data_export_repository.dart';

class ImportWellnessDataUseCase {
  const ImportWellnessDataUseCase(this.repository);
  final DataExportRepository repository;

  Future<WellnessExportBundle> call(String filePath) =>
      repository.importFromJsonFile(filePath);
}
