import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

class WellnessPhaseTimeline extends StatelessWidget {
  const WellnessPhaseTimeline({
    super.key,
    required this.currentDay,
    this.totalDays = 28,
    this.compact = false,
  });

  final int currentDay;
  final int totalDays;
  final bool compact;

  static const _phases = [
    _Phase('Menstrual', 1, 5, WellnessColors.period),
    _Phase('Follicular', 6, 13, WellnessColors.secondary),
    _Phase('Ovulation', 14, 16, WellnessColors.ovulation),
    _Phase('Luteal', 17, 28, WellnessColors.pms),
  ];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!compact) ...[
          Text(
            'Cycle timeline',
            style: WellnessTextStyles.section.copyWith(
              color: WellnessColors.textSecondaryFor(brightness),
            ),
          ),
          const SizedBox(height: WellnessSpacing.md),
        ],
        Row(
          children: _phases
              .map(
                (phase) => Expanded(
                  flex: phase.end - phase.start + 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      height: 14,
                      decoration: BoxDecoration(
                        color: phase.color.withValues(
                          alpha: phase.contains(currentDay) ? 0.95 : 0.42,
                        ),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: phase.contains(currentDay)
                            ? [
                                BoxShadow(
                                  color: phase.color.withValues(alpha: 0.28),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ]
                            : const [],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: compact ? WellnessSpacing.xs : WellnessSpacing.sm),
        Wrap(
          spacing: compact ? WellnessSpacing.sm : WellnessSpacing.md,
          runSpacing: WellnessSpacing.sm,
          children: _phases
              .map(
                (phase) => Text(
                  '${phase.label} ${phase.start}-${phase.end}',
                  style: WellnessTextStyles.caption(context).copyWith(
                    color: phase.contains(currentDay)
                        ? WellnessColors.textPrimaryFor(brightness)
                        : WellnessColors.textSecondaryFor(brightness),
                    fontWeight: phase.contains(currentDay)
                        ? FontWeight.w700
                        : FontWeight.w500,
                    fontSize: compact ? 11 : null,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _Phase {
  const _Phase(this.label, this.start, this.end, this.color);

  final String label;
  final int start;
  final int end;
  final Color color;

  bool contains(int day) => day >= start && day <= end;
}
