import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/usecases/get_wellness_dashboard_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Dashboard state and actions.
class WellnessDashboardController extends GetxController {
  WellnessDashboardController(this.getDashboardUseCase);

  final GetWellnessDashboardUseCase getDashboardUseCase;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final dashboard = Rxn<WellnessDashboardData>();
  final selectedTabIndex = 0.obs;

  String get dailyTip {
    final index = DateTime.now().day % WellnessConstants.tips.length;
    return WellnessConstants.tips[index];
  }

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      dashboard.value = await getDashboardUseCase();
    } catch (_) {
      errorMessage.value = WellnessConstants.error;
    } finally {
      isLoading.value = false;
    }
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
}
