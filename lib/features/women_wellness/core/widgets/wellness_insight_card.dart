import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';

class WellnessInsightCard extends StatelessWidget {
  const WellnessInsightCard({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.tint,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final accent = tint ?? WellnessColors.primaryHot;

    return WellnessGlassCard(
      padding: const EdgeInsets.all(WellnessSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: accent.withValues(
                alpha: brightness == Brightness.dark ? 0.18 : 0.24,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: accent.withValues(alpha: 0.28)),
            ),
            child: Icon(
              icon,
              color: brightness == Brightness.dark
                  ? WellnessColors.darkTextPrimary
                  : WellnessColors.primaryDeep,
            ),
          ),
          const SizedBox(width: WellnessSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: WellnessTextStyles.sectionHeader(
                    brightness,
                  ).copyWith(fontSize: 22),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: WellnessTextStyles.bodyForBrightness(brightness),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
