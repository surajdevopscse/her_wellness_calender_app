import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';

/// Grouped privacy settings with section title and hint.
class PrivacySettingsSection extends StatelessWidget {
  const PrivacySettingsSection({
    super.key,
    required this.title,
    required this.hint,
    required this.children,
    this.icon,
  });

  final String title;
  final String hint;
  final List<Widget> children;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return WellnessGlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              WellnessSpacing.lg,
              WellnessSpacing.lg,
              WellnessSpacing.lg,
              WellnessSpacing.sm,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          WellnessColors.primaryHot.withValues(alpha: 0.78),
                          WellnessColors.secondary.withValues(alpha: 0.45),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      size: 22,
                      color: WellnessColors.textOnPrimary,
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
                        style: WellnessTextStyles.sectionHeader(brightness),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hint,
                        style: WellnessTextStyles.caption(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
