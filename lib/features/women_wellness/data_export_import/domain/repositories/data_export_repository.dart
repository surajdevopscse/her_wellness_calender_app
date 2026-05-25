import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/export_file_result.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/wellness_export_bundle.dart';

abstract class DataExportRepository {
  Future<WellnessExportBundle> buildExportBundle();
  Future<ExportFileResult> exportJson(WellnessExportBundle bundle);
  Future<ExportFileResult> exportCsv(WellnessExportBundle bundle);
  Future<WellnessExportBundle> importFromJsonFile(String filePath);
}
