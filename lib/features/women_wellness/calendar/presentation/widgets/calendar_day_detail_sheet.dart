import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/calendar/domain/entities/calendar_day_detail.dart';
import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

typedef CalendarDayAction = void Function(DateTime date);

/// Bottom sheet for a selected calendar day.
class CalendarDayDetailSheet extends StatelessWidget {
  const CalendarDayDetailSheet({
    super.key,
    required this.detail,
    required this.onAddLog,
    required this.onEditLog,
    required this.onAddPeriod,
  });

  final CalendarDayDetail detail;
  final CalendarDayAction onAddLog;
  final CalendarDayAction onEditLog;
  final CalendarDayAction onAddPeriod;

  static Future<void> show(
    BuildContext context, {
    required CalendarDayDetail detail,
    required CalendarDayAction onAddLog,
    required CalendarDayAction onEditLog,
    required CalendarDayAction onAddPeriod,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CalendarDayDetailSheet(
        detail: detail,
        onAddLog: onAddLog,
        onEditLog: onEditLog,
        onAddPeriod: onAddPeriod,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        margin: const EdgeInsets.all(WellnessSpacing.lg),
        padding: const EdgeInsets.fromLTRB(
          WellnessSpacing.xl,
          WellnessSpacing.lg,
          WellnessSpacing.xl,
          WellnessSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: WellnessColors.cardFor(brightness),
          borderRadius: BorderRadius.circular(WellnessSpacing.cardRadius),
          border: Border.all(color: WellnessColors.borderFor(brightness)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: WellnessColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: WellnessSpacing.lg),
            Text(
              WellnessDateHelper.weekdayMonthDay.format(detail.date),
              style: WellnessTextStyles.sectionHeader(brightness),
            ),
            const SizedBox(height: WellnessSpacing.sm),
            Text(
              'Cycle day ${detail.cycleDay} · Next period in ${detail.daysUntilNextPeriod} days',
              style: WellnessTextStyles.caption(context),
            ),
            const SizedBox(height: WellnessSpacing.lg),
            Wrap(
              spacing: WellnessSpacing.sm,
              runSpacing: WellnessSpacing.sm,
              children: detail.dayTypes.map((type) {
                return Chip(
                  avatar: Icon(type.icon, size: 18, color: type.color),
                  label: Text(type.label),
                  backgroundColor: type.color.withValues(alpha: 0.15),
                );
              }).toList(),
            ),
            if (detail.period != null) ...[
              const SizedBox(height: WellnessSpacing.lg),
              _InfoBlock(
                title: 'Period entry',
                lines: [
                  if (detail.period!.notes != null) detail.period!.notes!,
                  if (detail.period!.irregularCycleNote != null)
                    detail.period!.irregularCycleNote!,
                ],
              ),
            ],
            if (detail.log != null) ...[
              const SizedBox(height: WellnessSpacing.lg),
              _InfoBlock(
                title: 'Daily log',
                lines: [
                  detail.log!.mood.description,
                  detail.log!.flow.description,
                  detail.log!.painLevel.description,
                  '${detail.log!.energyLevel.description} · ${detail.log!.sleepQuality.description}',
                  if (detail.log!.symptoms.isNotEmpty)
                    detail.log!.symptoms.map((s) => s.label).join(', '),
                  if (detail.log!.customNotes != null) detail.log!.customNotes!,
                ],
              ),
            ],
            const SizedBox(height: WellnessSpacing.xl),
            if (detail.hasLog)
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  onEditLog(detail.date);
                },
                icon: const Icon(Icons.edit_note_outlined),
                label: const Text('Edit daily log'),
              )
            else
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  onAddLog(detail.date);
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Add daily log'),
              ),
            const SizedBox(height: WellnessSpacing.sm),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                onAddPeriod(detail.date);
              },
              icon: const Icon(Icons.water_drop_outlined),
              label: Text(detail.hasPeriod ? 'Edit period' : 'Add period'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({required this.title, required this.lines});

  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: WellnessTextStyles.label),
        const SizedBox(height: WellnessSpacing.xs),
        for (final line in lines.where((l) => l.isNotEmpty))
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(line, style: WellnessTextStyles.bodyFor(context)),
          ),
      ],
    );
  }
}
