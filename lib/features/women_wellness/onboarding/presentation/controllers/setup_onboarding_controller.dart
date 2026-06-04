import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_validators.dart';
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
  final errorMessage = ''.obs;

  bool get canContinue {
    if (pageIndex.value == 0) return selectedGoal.value.isNotEmpty;
    if (pageIndex.value == 1) return selectedDate.value != null;
    return true;
  }

  void selectGoal(String goal) {
    errorMessage.value = '';
    selectedGoal.value = goal;
  }

  void selectDate(DateTime date) {
    errorMessage.value = '';
    selectedDate.value = date;
  }

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
    errorMessage.value = '';
    if (cycleLength.value < 45) cycleLength.value++;
  }

  void decrementCycleLength() {
    errorMessage.value = '';
    if (cycleLength.value > 21) cycleLength.value--;
  }

  void incrementPeriodLength() {
    errorMessage.value = '';
    if (periodLength.value < 10) periodLength.value++;
  }

  void decrementPeriodLength() {
    errorMessage.value = '';
    if (periodLength.value > 2) periodLength.value--;
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
    Get.offAllNamed(AuthenticationRoutes.login);
  }

  Future<void> completeSetup() async {
    final lastPeriodStart = selectedDate.value;
    if (selectedGoal.value.isEmpty || lastPeriodStart == null) return;

    final dateError = WellnessValidators.validateDateNotInFuture(
      lastPeriodStart,
    );
    final cycleError = WellnessValidators.validateCycleLength(
      cycleLength.value,
    );
    final periodError = WellnessValidators.validatePeriodLength(
      periodLength.value,
    );
    final validationError = dateError ?? cycleError ?? periodError;
    if (validationError != null) {
      _showError(validationError);
      return;
    }

    isSaving.value = true;
    errorMessage.value = '';
    try {
      await completeSetupOnboardingUseCase(
        goal: selectedGoal.value,
        lastPeriodStart: lastPeriodStart,
        cycleLength: cycleLength.value,
        periodLength: periodLength.value,
      );
      Get.snackbar(
        WellnessConstants.onboardingTitle,
        WellnessConstants.onboardingSaveSuccess,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed(WellnessRoutes.dashboard);
    } catch (error) {
      _showError(
        error is AppException
            ? error.message
            : WellnessConstants.onboardingSaveError,
      );
    } finally {
      isSaving.value = false;
    }
  }

  void _showError(String message) {
    errorMessage.value = message;
    Get.snackbar(
      WellnessConstants.onboardingTitle,
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
