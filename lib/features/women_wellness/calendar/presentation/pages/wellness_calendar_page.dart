import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/domain/usecases/get_calendar_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/controllers/wellness_calendar_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/widgets/calendar_legend.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/widgets/wellness_calendar.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_empty_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_phase_timeline.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';

/// Calendar view with period, fertility, PMS, ovulation, and log markers.
class WellnessCalendarPage extends GetView<WellnessCalendarController> {
  const WellnessCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      final data = controller.calendarData.value;
      if (data == null) {
        return const WellnessEmptyState(
          message: WellnessConstants.calendarEmpty,
        );
      }
      final focused = controller.selectedDate.value;
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          WellnessSpacing.lg,
          WellnessSpacing.lg,
          WellnessSpacing.lg,
          WellnessResponsive.bottomContentInset(context),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: WellnessSpacing.pageMaxWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeInContainer(
                  child: WellnessCard(
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? WellnessColors.darkSurface
                                : WellnessColors.secondary.withValues(
                                    alpha: 0.42,
                                  ),
                            border: Border.all(
                              color: WellnessColors.borderFor(
                                Theme.of(context).brightness,
                              ).withValues(alpha: 0.7),
                            ),
                          ),
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? WellnessColors.darkPrimary
                                : WellnessColors.primaryDeep,
                          ),
                        ),
                        const SizedBox(width: WellnessSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your month at a glance',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'See upcoming fertile days, ovulation timing, PMS, and logged entries in one clear calendar.',
                                style: WellnessTextStyles.caption(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                FadeInContainer(
                  delay: const Duration(milliseconds: 60),
                  child: WellnessCard(
                    padding: const EdgeInsets.all(WellnessSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        WellnessCalendarMonthHeader(month: focused),
                        const SizedBox(height: WellnessSpacing.md),
                        _CalendarStatusRow(data: data),
                        const SizedBox(height: WellnessSpacing.sm),
                        WellnessCalendar(
                          focusedDay: focused,
                          selectedDay: focused,
                          periods: data.periods,
                          logs: data.logs,
                          prediction: data.prediction,
                          onDaySelected: (date) {
                            controller.selectDate(date);
                            controller.openDayDetail(context, date);
                          },
                        ),
                        const SizedBox(height: WellnessSpacing.lg),
                        WellnessPhaseTimeline(
                          currentDay: data.prediction.currentCycleDay,
                        ),
                        const SizedBox(height: WellnessSpacing.lg),
                        const CalendarLegend(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _CalendarStatusRow extends StatelessWidget {
  const _CalendarStatusRow({required this.data});

  final CalendarData data;

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'Next period',
        '${data.prediction.daysUntilNextPeriod} days',
        Icons.water_drop_outlined,
      ),
      (
        'Ovulation',
        WellnessDateHelper.shortDate.format(data.prediction.ovulationDate),
        Icons.wb_sunny_outlined,
      ),
      (
        'Current day',
        'Day ${data.prediction.currentCycleDay}',
        Icons.auto_graph_rounded,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;
        if (compact) {
          return Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                _StatusPill(
                  label: items[i].$1,
                  value: items[i].$2,
                  icon: items[i].$3,
                ),
                if (i < items.length - 1)
                  const SizedBox(height: WellnessSpacing.sm),
              ],
            ],
          );
        }
        return Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              Expanded(
                child: _StatusPill(
                  label: items[i].$1,
                  value: items[i].$2,
                  icon: items[i].$3,
                ),
              ),
              if (i < items.length - 1)
                const SizedBox(width: WellnessSpacing.sm),
            ],
          ],
        );
      },
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WellnessSpacing.md,
        vertical: WellnessSpacing.md,
      ),
      decoration: BoxDecoration(
        color: brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: WellnessColors.borderFor(brightness).withValues(alpha: 0.38),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: WellnessColors.primaryDeep),
          const SizedBox(width: WellnessSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 2),
                Text(value, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
