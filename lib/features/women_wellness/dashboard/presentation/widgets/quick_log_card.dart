import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// One-tap quick log: period, daily log, and common moods.
class QuickLogCard extends StatelessWidget {
  const QuickLogCard({
    super.key,
    required this.onAddPeriod,
    required this.onAddLog,
    this.onMoodTap,
  });

  final VoidCallback onAddPeriod;
  final VoidCallback onAddLog;
  final ValueChanged<MoodType>? onMoodTap;

  static const _quickMoods = [
    MoodType.happy,
    MoodType.tired,
    MoodType.anxious,
    MoodType.sad,
    MoodType.emotional,
  ];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final sectionTint = Theme.of(context).colorScheme.surfaceContainerHighest;

    return FadeInContainer(
      delay: const Duration(milliseconds: 160),
      child: WellnessCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Quick check-in',
                    style: WellnessTextStyles.sectionHeader(brightness),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: sectionTint.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Under 1 minute',
                    style: WellnessTextStyles.caption(context).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: WellnessSpacing.xs),
            Text(
              'Capture the essentials quickly, then return later for more detail if you need it.',
              style: WellnessTextStyles.body.copyWith(
                color: WellnessColors.textSecondaryFor(brightness),
              ),
            ),
            const SizedBox(height: WellnessSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.water_drop_outlined,
                    label: 'Period',
                    color: WellnessColors.period,
                    onTap: onAddPeriod,
                  ),
                ),
                const SizedBox(width: WellnessSpacing.md),
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.edit_note_outlined,
                    label: 'Daily log',
                    color: WellnessColors.secondary,
                    onTap: onAddLog,
                  ),
                ),
              ],
            ),
            const SizedBox(height: WellnessSpacing.lg),
            Text(
              'How are you feeling right now?',
              style: WellnessTextStyles.label.copyWith(
                color: WellnessColors.textSecondaryFor(brightness),
              ),
            ),
            const SizedBox(height: WellnessSpacing.sm),
            Wrap(
              spacing: WellnessSpacing.sm,
              runSpacing: WellnessSpacing.sm,
              children: _quickMoods.map((mood) {
                return ScaleTap(
                  onTap: () {
                    if (onMoodTap != null) {
                      onMoodTap!(mood);
                    } else {
                      onAddLog();
                    }
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: WellnessSpacing.minTouchTarget,
                      minHeight: WellnessSpacing.minTouchTarget,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: WellnessColors.blush.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(WellnessSpacing.pillRadius),
                      border: Border.all(color: WellnessColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(mood.icon, size: 20, color: WellnessColors.primaryDeep),
                        const SizedBox(width: 6),
                        Text(mood.label, style: WellnessTextStyles.label),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      child: Container(
        height: WellnessSpacing.minTouchTarget + 8,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.22),
          borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
          border: Border.all(color: color.withValues(alpha: 0.45)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 8),
            Text(label, style: WellnessTextStyles.label),
          ],
        ),
      ),
    );
  }
}
