import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'wellness_prediction_helper.dart';

/// Domain validation helpers for period and profile inputs.
class WellnessValidators {
  WellnessValidators._();

  static String? requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return WellnessConstants.requiredField;
    }
    return null;
  }

  static String? validateCycleLength(int value) {
    if (!WellnessPredictionHelper.isCycleLengthTypical(value)) {
      return WellnessConstants.cycleLengthRange;
    }
    return null;
  }

  static String? validatePeriodLength(int value) {
    if (value < 2 || value > 10) {
      return WellnessConstants.periodLengthRange;
    }
    return null;
  }

  static String? validatePeriodDates(DateTime? start, DateTime? end) {
    if (start == null) {
      return WellnessConstants.startDateRequired;
    }
    if (end != null && end.isBefore(start)) {
      return WellnessConstants.endBeforeStart;
    }
    return null;
  }

  static String? validateDateNotInFuture(DateTime? value) {
    if (value == null) return WellnessConstants.requiredField;
    final today = DateTime.now();
    if (value.isAfter(DateTime(today.year, today.month, today.day))) {
      return WellnessConstants.futureDateNotAllowed;
    }
    return null;
  }

  static bool isValidAgeGroup(String value) => value.trim().isNotEmpty;
}
