import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

/// Polished switch tile for one privacy setting.
class PrivacySettingTile extends StatelessWidget {
  const PrivacySettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final bool enabled;
  final bool showDivider;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final iconBg = value
        ? (isDark
            ? WellnessColors.darkPrimary.withValues(alpha: 0.25)
            : WellnessColors.primaryHot.withValues(alpha: 0.4))
        : (isDark ? WellnessColors.darkSurface : WellnessColors.blush);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: WellnessSpacing.lg,
            vertical: WellnessSpacing.md,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: value
                        ? WellnessColors.primaryDeep.withValues(alpha: 0.4)
                        : WellnessColors.borderFor(brightness).withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: value
                      ? (isDark
                          ? WellnessColors.darkPrimary
                          : WellnessColors.primaryDeep)
                      : WellnessColors.textSecondaryFor(brightness),
                ),
              ),
              const SizedBox(width: WellnessSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: WellnessTextStyles.section.copyWith(
                        color: WellnessColors.textPrimaryFor(brightness),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: WellnessTextStyles.caption(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: WellnessSpacing.sm),
              Switch.adaptive(
                value: value,
                onChanged: enabled ? onChanged : null,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: WellnessSpacing.lg + 46 + WellnessSpacing.md,
            endIndent: WellnessSpacing.lg,
            color: WellnessColors.borderFor(brightness).withValues(alpha: 0.45),
          ),
      ],
    );
  }
}
