import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/export_file_result.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/usecases/export_wellness_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/usecases/import_wellness_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/usecases/restore_wellness_data_usecase.dart';

class DataExportController extends GetxController {
  DataExportController(
    this.exportUseCase,
    this.importUseCase,
    this.restoreUseCase,
  );

  final ExportWellnessDataUseCase exportUseCase;
  final ImportWellnessDataUseCase importUseCase;
  final RestoreWellnessDataUseCase restoreUseCase;

  final isBusy = false.obs;
  final statusMessage = ''.obs;
  final lastExport = Rxn<ExportFileResult>();

  Future<void> exportJson() => _export(ExportFormat.json);

  Future<void> exportCsv() => _export(ExportFormat.csv);

  Future<void> _export(ExportFormat format) async {
    isBusy.value = true;
    statusMessage.value = '';
    try {
      final result = await exportUseCase(format);
      lastExport.value = result;
      statusMessage.value =
          'Saved ${result.fileName} (${result.byteLength} bytes)';
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(result.path)],
          text: 'Her Wellness Calendar export',
        ),
      );
    } catch (error) {
      statusMessage.value = 'Export failed: $error';
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> importBackup() async {
    isBusy.value = true;
    statusMessage.value = '';
    try {
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (picked == null || picked.files.single.path == null) {
        statusMessage.value = 'Import cancelled.';
        return;
      }
      final bundle = await importUseCase(picked.files.single.path!);
      await restoreUseCase(bundle);
      statusMessage.value =
          'Restored backup from ${bundle.exportedAt.toIso8601String()} '
          'with ${bundle.periods.length} periods and ${bundle.dailyLogs.length} daily logs.';
    } catch (error) {
      statusMessage.value = 'Import failed: $error';
    } finally {
      isBusy.value = false;
    }
  }
}
