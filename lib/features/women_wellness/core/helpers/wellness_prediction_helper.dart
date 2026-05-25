import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Calculates cycle predictions from profile values. Estimates only.
class WellnessPredictionHelper {
  WellnessPredictionHelper._();

  static const minCycleLength = 21;
  static const maxCycleLength = 45;
  static const defaultLutealPhaseDays = 14;
  static const fertileDaysBeforeOvulation = 5;
  static const fertileDaysAfterOvulation = 1;
  static const pmsWindowDays = 7;
  static const lateGraceDays = 3;

  static CyclePrediction calculate({
    required DateTime lastPeriodStartDate,
    required int averageCycleLength,
    required int averagePeriodLength,
    required DateTime today,
    bool isIrregular = false,
  }) {
    final normalizedCycleLength = averageCycleLength.clamp(
      minCycleLength,
      maxCycleLength,
    );
    final nextPeriodDate = lastPeriodStartDate.add(
      Duration(days: normalizedCycleLength),
    );
    final ovulationDate = nextPeriodDate.subtract(
      const Duration(days: defaultLutealPhaseDays),
    );
    final fertileWindowStart = ovulationDate.subtract(
      const Duration(days: fertileDaysBeforeOvulation),
    );
    final fertileWindowEnd = ovulationDate.add(
      const Duration(days: fertileDaysAfterOvulation),
    );
    final pmsStartDate = nextPeriodDate.subtract(
      const Duration(days: pmsWindowDays),
    );
    final pmsEndDate = nextPeriodDate.subtract(const Duration(days: 1));
    final currentCycleDay = today.difference(lastPeriodStartDate).inDays + 1;
    final daysUntilNextPeriod = nextPeriodDate.difference(today).inDays;
    final isLate = today.isAfter(
      nextPeriodDate.add(const Duration(days: lateGraceDays)),
    );
    final warnings = <String>[
      if (isIrregular) WellnessConstants.irregularCycleWarning,
      if (isLate) WellnessConstants.latePeriodMessage,
    ];
    return CyclePrediction(
      nextPeriodDate: nextPeriodDate,
      ovulationDate: ovulationDate,
      fertileWindowStart: fertileWindowStart,
      fertileWindowEnd: fertileWindowEnd,
      pmsStartDate: pmsStartDate,
      pmsEndDate: pmsEndDate,
      currentCycleDay: currentCycleDay,
      daysUntilNextPeriod: daysUntilNextPeriod,
      isLate: isLate,
      warningMessage: warnings.isEmpty ? null : warnings.join(' '),
    );
  }

  static bool isCycleLengthTypical(int value) =>
      value >= minCycleLength && value <= maxCycleLength;

  static DateTime estimateNextPeriodStart({
    required DateTime lastPeriodStartDate,
    required int averageCycleLength,
  }) => lastPeriodStartDate.add(Duration(days: averageCycleLength));

  static double cycleProgress({
    required DateTime lastPeriodStartDate,
    required int averageCycleLength,
    required DateTime today,
  }) {
    final elapsed = today.difference(lastPeriodStartDate).inDays + 1;
    return (elapsed / averageCycleLength).clamp(0, 1).toDouble();
  }
}
