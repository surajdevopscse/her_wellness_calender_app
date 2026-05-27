import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';

class WellnessSectionCard extends StatelessWidget {
  const WellnessSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return WellnessGlassCard(
      padding: const EdgeInsets.all(WellnessSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: brightness == Brightness.dark
                        ? WellnessColors.darkSurface
                        : WellnessColors.secondary.withValues(alpha: 0.42),
                    border: Border.all(
                      color: WellnessColors.borderFor(
                        brightness,
                      ).withValues(alpha: 0.7),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: brightness == Brightness.dark
                        ? WellnessColors.darkPrimary
                        : WellnessColors.primaryDeep,
                    size: 20,
                  ),
                ),
                const SizedBox(width: WellnessSpacing.md),
              ],
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
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: WellnessTextStyles.caption(context),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: WellnessSpacing.md),
          child,
        ],
      ),
    );
  }
}
