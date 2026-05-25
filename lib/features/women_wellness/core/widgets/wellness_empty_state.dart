import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';

/// Standard premium empty state view.
class WellnessEmptyState extends StatelessWidget {
  const WellnessEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.spa_outlined,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(WellnessSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: WellnessGlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        WellnessColors.primaryHot.withValues(alpha: 0.85),
                        WellnessColors.secondary.withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 38,
                    color: WellnessColors.textOnPrimary,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                Text(
                  'A calmer start',
                  textAlign: TextAlign.center,
                  style: WellnessTextStyles.sectionHeader(brightness),
                ),
                const SizedBox(height: WellnessSpacing.sm),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: WellnessTextStyles.body.copyWith(
                    color: WellnessColors.textSecondaryFor(brightness),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
