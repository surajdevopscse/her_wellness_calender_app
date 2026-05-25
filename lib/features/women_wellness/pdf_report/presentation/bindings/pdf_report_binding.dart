import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/domain/usecases/export_pdf_report_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/presentation/controllers/pdf_preview_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/usecases/get_reports_usecase.dart';

class PdfReportBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(() => GetReportsUseCase(Get.find<ReportsRepository>()));
    ensureLazyPut(
      () => ExportPdfReportUseCase(
        Get.find<WellnessProfileRepository>(),
        Get.find<PeriodTrackingRepository>(),
      ),
    );
    ensureLazyPut(
      () => PdfPreviewController(
        Get.find<GetReportsUseCase>(),
        Get.find<ExportPdfReportUseCase>(),
      ),
    );
  }
}
