import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/usecases/get_reports_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Loads wellness analytics reports.
class ReportsController extends GetxController {
  ReportsController(this.getReportsUseCase);

  final GetReportsUseCase getReportsUseCase;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final report = Rxn<WellnessReport>();

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
    } catch (_) {
      errorMessage.value = WellnessConstants.error;
    } finally {
      isLoading.value = false;
    }
  }
}
