import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';

/// Snapshot of cycle phase and logs for one calendar day.
class CalendarDayDetail {
  const CalendarDayDetail({
    required this.date,
    required this.dayTypes,
    this.period,
    this.log,
    required this.cycleDay,
    required this.daysUntilNextPeriod,
  });

  final DateTime date;
  final List<WellnessCalendarDayType> dayTypes;
  final PeriodEntry? period;
  final DailyLog? log;
  final int cycleDay;
  final int daysUntilNextPeriod;

  bool get hasLog => log != null;
  bool get hasPeriod => period != null;

  static CalendarDayDetail fromData({
    required DateTime date,
    required List<PeriodEntry> periods,
    required List<DailyLog> logs,
    required CyclePrediction prediction,
  }) {
    final types = <WellnessCalendarDayType>[];
    PeriodEntry? period;
    for (final entry in periods) {
      final end = entry.endDate ?? entry.startDate;
      if (!date.isBefore(entry.startDate) && !date.isAfter(end)) {
        types.add(WellnessCalendarDayType.confirmedPeriod);
        period = entry;
        break;
      }
    }
    final predictedEnd = prediction.nextPeriodDate.add(const Duration(days: 4));
    if (period == null &&
        !date.isBefore(prediction.nextPeriodDate) &&
        !date.isAfter(predictedEnd)) {
      types.add(WellnessCalendarDayType.predictedPeriod);
    }
    if (_sameDay(date, prediction.ovulationDate)) {
      types.add(WellnessCalendarDayType.ovulation);
    }
    if (!date.isBefore(prediction.fertileWindowStart) &&
        !date.isAfter(prediction.fertileWindowEnd)) {
      types.add(WellnessCalendarDayType.fertileWindow);
    }
    if (!date.isBefore(prediction.pmsStartDate) &&
        !date.isAfter(prediction.pmsEndDate)) {
      types.add(WellnessCalendarDayType.pms);
    }
    DailyLog? log;
    for (final item in logs) {
      if (_sameDay(item.logDate, date)) {
        log = item;
        types.add(WellnessCalendarDayType.logged);
        break;
      }
    }
    if (types.isEmpty) types.add(WellnessCalendarDayType.normal);

    return CalendarDayDetail(
      date: date,
      dayTypes: types.toSet().toList(),
      period: period,
      log: log,
      cycleDay: prediction.currentCycleDay,
      daysUntilNextPeriod: prediction.daysUntilNextPeriod,
    );
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
