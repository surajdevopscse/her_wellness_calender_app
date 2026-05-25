import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';

enum _DayMarker { period, predicted, ovulation, fertile, pms }

/// Calendar with swipe navigation, phase markers, and polished day cells.
class WellnessCalendar extends StatefulWidget {
  const WellnessCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.periods,
    required this.logs,
    required this.prediction,
    required this.onDaySelected,
    this.onMonthChanged,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final List<PeriodEntry> periods;
  final List<DailyLog> logs;
  final CyclePrediction prediction;
  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<DateTime>? onMonthChanged;

  @override
  State<WellnessCalendar> createState() => _WellnessCalendarState();
}

class _WellnessCalendarState extends State<WellnessCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
    _selectedDay = widget.selectedDay;
  }

  @override
  void didUpdateWidget(covariant WellnessCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!WellnessDateHelper.isSameDay(oldWidget.focusedDay, widget.focusedDay)) {
      _focusedDay = widget.focusedDay;
    }
    if (!WellnessDateHelper.isSameDay(oldWidget.selectedDay, widget.selectedDay)) {
      _selectedDay = widget.selectedDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textPrimary = WellnessColors.textPrimaryFor(brightness);

    return TableCalendar<void>(
      firstDay: DateTime(2024),
      lastDay: DateTime(2030),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => WellnessDateHelper.isSameDay(day, _selectedDay),
      availableGestures: AvailableGestures.horizontalSwipe,
      rowHeight: WellnessSpacing.calendarCellSize,
      daysOfWeekHeight: 32,
      onDaySelected: (selected, focused) {
        setState(() {
          _selectedDay = selected;
          _focusedDay = focused;
        });
        widget.onDaySelected(selected);
      },
      onPageChanged: (focused) {
        setState(() => _focusedDay = focused);
        widget.onMonthChanged?.call(focused);
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: WellnessTextStyles.sectionHeader(brightness),
        leftChevronIcon: Icon(Icons.chevron_left_rounded, color: textPrimary),
        rightChevronIcon: Icon(Icons.chevron_right_rounded, color: textPrimary),
        headerPadding: const EdgeInsets.symmetric(vertical: WellnessSpacing.md),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: WellnessTextStyles.label.copyWith(
          color: WellnessColors.textSecondaryFor(brightness),
        ),
        weekendStyle: WellnessTextStyles.label.copyWith(
          color: WellnessColors.primaryDeep,
          fontWeight: FontWeight.w700,
        ),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        defaultTextStyle: WellnessTextStyles.body,
        weekendTextStyle: WellnessTextStyles.body.copyWith(
          color: WellnessColors.primaryDeep,
        ),
        todayTextStyle: WellnessTextStyles.body.copyWith(
          fontWeight: FontWeight.w700,
        ),
        selectedTextStyle: WellnessTextStyles.body.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        cellMargin: const EdgeInsets.all(3),
        cellPadding: EdgeInsets.zero,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) => _buildDay(context, day),
        todayBuilder: (context, day, _) => _buildDay(context, day, isToday: true),
        selectedBuilder: (context, day, _) =>
            _buildDay(context, day, isSelected: true),
        outsideBuilder: (context, day, _) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildDay(
    BuildContext context,
    DateTime day, {
    bool isToday = false,
    bool isSelected = false,
  }) {
    final marker = _markerFor(day);
    final color = _colorForMarker(marker);
    final hasLog = _hasLog(day);
    final isWeekend = day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

    Widget cell = _DayCell(
      day: day,
      marker: marker,
      color: color,
      hasLog: hasLog,
      isWeekend: isWeekend,
      isToday: isToday,
      isSelected: isSelected,
    );

    if (isToday && !isSelected) {
      cell = PulseIndicator(child: cell);
    }

    return cell;
  }

  _DayMarker? _markerFor(DateTime day) {
    for (final period in widget.periods) {
      final end = period.endDate ?? period.startDate;
      if (!day.isBefore(period.startDate) && !day.isAfter(end)) {
        return _DayMarker.period;
      }
    }
    final predictedEnd = widget.prediction.nextPeriodDate.add(const Duration(days: 4));
    if (!day.isBefore(widget.prediction.nextPeriodDate) &&
        !day.isAfter(predictedEnd)) {
      return _DayMarker.predicted;
    }
    if (WellnessDateHelper.isSameDay(day, widget.prediction.ovulationDate)) {
      return _DayMarker.ovulation;
    }
    if (!day.isBefore(widget.prediction.fertileWindowStart) &&
        !day.isAfter(widget.prediction.fertileWindowEnd)) {
      return _DayMarker.fertile;
    }
    if (!day.isBefore(widget.prediction.pmsStartDate) &&
        !day.isAfter(widget.prediction.pmsEndDate)) {
      return _DayMarker.pms;
    }
    return null;
  }

  Color? _colorForMarker(_DayMarker? marker) => switch (marker) {
        _DayMarker.period => WellnessColors.period,
        _DayMarker.predicted => WellnessColors.predicted,
        _DayMarker.ovulation => WellnessColors.ovulation,
        _DayMarker.fertile => WellnessColors.fertile,
        _DayMarker.pms => WellnessColors.pms,
        null => null,
      };

  bool _hasLog(DateTime day) =>
      widget.logs.any((log) => WellnessDateHelper.isSameDay(log.logDate, day));
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.marker,
    required this.color,
    required this.hasLog,
    required this.isWeekend,
    required this.isToday,
    required this.isSelected,
  });

  final DateTime day;
  final _DayMarker? marker;
  final Color? color;
  final bool hasLog;
  final bool isWeekend;
  final bool isToday;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final weekendTint = isWeekend
        ? WellnessColors.lavender.withValues(alpha: brightness == Brightness.dark ? 0.2 : 0.45)
        : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isSelected
            ? WellnessColors.primaryDeep
            : color?.withValues(alpha: isSelected ? 1 : 0.55) ?? weekendTint,
        borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
        border: Border.all(
          color: isToday && !isSelected
              ? WellnessColors.primaryHot
              : isSelected
                  ? WellnessColors.primaryDeep
                  : Colors.transparent,
          width: isToday ? 2 : 0,
        ),
        gradient: marker == _DayMarker.period && !isSelected
            ? LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  WellnessColors.period.withValues(alpha: 0.9),
                  WellnessColors.period.withValues(alpha: 0.15),
                ],
              )
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isToday || isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : WellnessColors.textPrimaryFor(brightness),
            ),
          ),
          if (marker == _DayMarker.fertile)
            const Positioned(top: 4, right: 4, child: Icon(Icons.eco, size: 11, color: WellnessColors.fertileDeep)),
          if (marker == _DayMarker.ovulation)
            const Positioned(top: 4, right: 4, child: Icon(Icons.wb_sunny, size: 11, color: WellnessColors.ovulationDeep)),
          if (hasLog)
            Positioned(
              right: 6,
              bottom: 5,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: WellnessColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Month title with seasonal accent for calendar header area.
class WellnessCalendarMonthHeader extends StatelessWidget {
  const WellnessCalendarMonthHeader({super.key, required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final title = DateFormat.yMMMM().format(month);
    final seasonIcon = _seasonIcon(month.month);

    return Padding(
      padding: const EdgeInsets.only(bottom: WellnessSpacing.sm),
      child: Row(
        children: [
          Icon(seasonIcon, color: WellnessColors.primaryHot, size: 22),
          const SizedBox(width: WellnessSpacing.sm),
          Text(title, style: WellnessTextStyles.sectionHeader(brightness)),
        ],
      ),
    );
  }

  IconData _seasonIcon(int month) {
    if (month >= 3 && month <= 5) return Icons.local_florist_outlined;
    if (month >= 6 && month <= 8) return Icons.wb_sunny_outlined;
    if (month >= 9 && month <= 11) return Icons.park_outlined;
    return Icons.ac_unit_outlined;
  }
}
