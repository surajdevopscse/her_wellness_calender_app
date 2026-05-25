import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/get_period_history_usecase.dart';

/// Loads cycle history.
class CycleHistoryController extends GetxController {
  CycleHistoryController(this.getPeriodHistoryUseCase);

  final GetPeriodHistoryUseCase getPeriodHistoryUseCase;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final periods = <PeriodEntry>[].obs;

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      periods.value = await getPeriodHistoryUseCase();
    } catch (_) {
      errorMessage.value = WellnessConstants.error;
    } finally {
      isLoading.value = false;
    }
  }
}
