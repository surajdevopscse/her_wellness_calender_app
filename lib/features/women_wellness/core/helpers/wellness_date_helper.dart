import 'package:intl/intl.dart';

/// Date formatting and comparison helpers.
class WellnessDateHelper {
  WellnessDateHelper._();

  static final DateFormat shortDate = DateFormat('MMM d, yyyy');
  static final DateFormat shortMonthDay = DateFormat('MMM d');
  static final DateFormat monthYear = DateFormat('MMMM yyyy');
  static final DateFormat weekdayMonthDay = DateFormat('EEE, MMM d');
  static final DateFormat apiDate = DateFormat('yyyy-MM-dd');

  static bool isSameDay(DateTime left, DateTime right) =>
      left.year == right.year &&
      left.month == right.month &&
      left.day == right.day;

  static DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  static DateTime startOfMonth(DateTime value) =>
      DateTime(value.year, value.month);

  static DateTime endOfMonth(DateTime value) =>
      DateTime(value.year, value.month + 1, 0);

  static int daysBetween(DateTime start, DateTime end) =>
      dateOnly(end).difference(dateOnly(start)).inDays;

  static bool isWithinInclusive(DateTime value, DateTime start, DateTime end) {
    final date = dateOnly(value);
    return !date.isBefore(dateOnly(start)) && !date.isAfter(dateOnly(end));
  }

  static List<DateTime> dateRange(DateTime start, DateTime end) {
    final first = dateOnly(start);
    final last = dateOnly(end);
    if (last.isBefore(first)) return const [];
    return List<DateTime>.generate(
      last.difference(first).inDays + 1,
      (index) => first.add(Duration(days: index)),
    );
  }

  static String formatShort(DateTime value) => shortDate.format(value);

  static String formatApi(DateTime value) => apiDate.format(value);

  static DateTime? tryParseApi(String value) {
    try {
      return apiDate.parseStrict(value);
    } on FormatException {
      return null;
    }
  }
}
