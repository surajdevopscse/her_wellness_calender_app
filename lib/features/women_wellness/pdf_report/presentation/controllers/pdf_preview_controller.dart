import 'dart:typed_data';

import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/domain/usecases/export_pdf_report_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/usecases/get_reports_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// PDF preview and export state.
class PdfPreviewController extends GetxController {
  PdfPreviewController(this.getReportsUseCase, this.exportPdfReportUseCase);

  final GetReportsUseCase getReportsUseCase;
  final ExportPdfReportUseCase exportPdfReportUseCase;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final report = Rxn<WellnessReport>();
  final pdfBytes = Rxn<Uint8List>();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      report.value = await getReportsUseCase();
      pdfBytes.value = await exportPdfReportUseCase(report.value!);
    } catch (_) {
      errorMessage.value = WellnessConstants.error;
    } finally {
      isLoading.value = false;
    }
  }
}
