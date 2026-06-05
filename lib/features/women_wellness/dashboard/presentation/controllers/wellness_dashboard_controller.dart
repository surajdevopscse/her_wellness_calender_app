import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
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
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = WellnessConstants.dashboardLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    await load();
    if (errorMessage.value.isEmpty) {
      Get.snackbar(
        WellnessConstants.dashboardTitle,
        WellnessConstants.dashboardRefreshSuccess,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void selectTab(int index) {
    final shouldReloadDashboard = index == 0 && selectedTabIndex.value != 0;
    selectedTabIndex.value = index;
    if (shouldReloadDashboard) {
      load();
    }
  }
}
