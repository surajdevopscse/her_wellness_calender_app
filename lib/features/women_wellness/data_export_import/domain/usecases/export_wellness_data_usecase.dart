import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/export_file_result.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/repositories/data_export_repository.dart';

enum ExportFormat { json, csv }

class ExportWellnessDataUseCase {
  const ExportWellnessDataUseCase(this.repository);
  final DataExportRepository repository;

  Future<ExportFileResult> call(ExportFormat format) async {
    final bundle = await repository.buildExportBundle();
    return switch (format) {
      ExportFormat.json => repository.exportJson(bundle),
      ExportFormat.csv => repository.exportCsv(bundle),
    };
  }
}
