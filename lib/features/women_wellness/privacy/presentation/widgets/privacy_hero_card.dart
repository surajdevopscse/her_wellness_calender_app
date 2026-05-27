import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Warm hero for privacy screen with trust reassurance.
class PrivacyHeroCard extends StatelessWidget {
  const PrivacyHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return FadeInContainer(
      child: WellnessCard(
        padding: const EdgeInsets.all(WellnessSpacing.xl),
        color: isDark ? WellnessColors.darkCard : WellnessColors.surface,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -8,
              top: -12,
              child: Icon(
                Icons.shield_outlined,
                size: 100,
                color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.14),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.22),
                    borderRadius: BorderRadius.circular(
                      WellnessSpacing.controlRadius,
                    ),
                  ),
                  child: Icon(
                    Icons.lock_person_outlined,
                    color: isDark
                        ? WellnessColors.darkPrimary
                        : WellnessColors.primaryDeep,
                    size: 28,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                Text(
                  WellnessConstants.privacyHeroTitle,
                  style: WellnessTextStyles.display(
                    color: WellnessColors.textPrimaryFor(brightness),
                  ).copyWith(fontSize: 26),
                ),
                const SizedBox(height: WellnessSpacing.sm),
                Text(
                  WellnessConstants.privacyHeroSubtitle,
                  style: WellnessTextStyles.body.copyWith(
                    color: WellnessColors.textSecondaryFor(brightness),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: WellnessSpacing.md,
                    vertical: WellnessSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : WellnessColors.secondary.withValues(alpha: 0.38),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: WellnessColors.borderFor(brightness),
                    ),
                  ),
                  child: Text(
                    'You control reminders, previews, storage, and deletion from one place.',
                    style: WellnessTextStyles.caption(context).copyWith(
                      color: WellnessColors.textSecondaryFor(brightness),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                const _TrustRow(text: WellnessConstants.privacyTrustNoSell),
                const SizedBox(height: WellnessSpacing.sm),
                const _TrustRow(text: WellnessConstants.privacyTrustOnDevice),
                const SizedBox(height: WellnessSpacing.sm),
                const _TrustRow(text: WellnessConstants.privacyTrustDelete),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrustRow extends StatelessWidget {
  const _TrustRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 18,
          color: isDark
              ? WellnessColors.darkAccent
              : WellnessColors.primaryDeep,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: WellnessTextStyles.body.copyWith(
              color: WellnessColors.textSecondaryFor(
                Theme.of(context).brightness,
              ),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
