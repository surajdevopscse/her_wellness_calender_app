import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/usecases/complete_setup_onboarding_usecase.dart';

class SetupOnboardingController extends GetxController {
  SetupOnboardingController(this.completeSetupOnboardingUseCase);

  final CompleteSetupOnboardingUseCase completeSetupOnboardingUseCase;

  static const totalSteps = 4;
  static const goalTrackPeriod = 'track_period';
  static const goalGetPregnant = 'get_pregnant';
  static const goalTrackPregnancy = 'track_pregnancy';
  static const goalHealthInsights = 'health_insights';

  final pageIndex = 0.obs;
  final selectedGoal = ''.obs;
  final selectedDate = Rxn<DateTime>();
  final visibleMonth = DateTime(DateTime.now().year, DateTime.now().month).obs;
  final cycleLength = 28.obs;
  final periodLength = 5.obs;
  final isSaving = false.obs;

  bool get canContinue {
    if (pageIndex.value == 0) return selectedGoal.value.isNotEmpty;
    if (pageIndex.value == 1) return selectedDate.value != null;
    return true;
  }

  void selectGoal(String goal) => selectedGoal.value = goal;

  void selectDate(DateTime date) => selectedDate.value = date;

  void previousMonth() {
    visibleMonth.value = DateTime(
      visibleMonth.value.year,
      visibleMonth.value.month - 1,
    );
  }

  void nextMonth() {
    visibleMonth.value = DateTime(
      visibleMonth.value.year,
      visibleMonth.value.month + 1,
    );
  }

  void incrementCycleLength() {
    if (cycleLength.value < 45) cycleLength.value++;
  }

  void decrementCycleLength() {
    if (cycleLength.value > 18) cycleLength.value--;
  }

  void incrementPeriodLength() {
    if (periodLength.value < 12) periodLength.value++;
  }

  void decrementPeriodLength() {
    if (periodLength.value > 1) periodLength.value--;
  }

  void next() {
    if (!canContinue || isSaving.value) return;
    if (pageIndex.value < totalSteps - 1) {
      pageIndex.value++;
      return;
    }
    completeSetup();
  }

  void back() {
    if (pageIndex.value > 0) {
      pageIndex.value--;
      return;
    }
    Get.offAllNamed(WellnessRoutes.dashboard);
  }

  Future<void> completeSetup() async {
    final lastPeriodStart = selectedDate.value;
    if (selectedGoal.value.isEmpty || lastPeriodStart == null) return;

    isSaving.value = true;
    try {
      await completeSetupOnboardingUseCase(
        goal: selectedGoal.value,
        lastPeriodStart: lastPeriodStart,
        cycleLength: cycleLength.value,
        periodLength: periodLength.value,
      );
      Get.offAllNamed(WellnessRoutes.dashboard);
    } finally {
      isSaving.value = false;
    }
  }
}
