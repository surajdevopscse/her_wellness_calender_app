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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  WellnessColors.darkCard,
                  const Color(0xFF4A2F38),
                  WellnessColors.darkPrimary.withValues(alpha: 0.35),
                ]
              : [
                  WellnessColors.primaryHot,
                  WellnessColors.primary,
                  WellnessColors.primaryDeep,
                ],
        ),
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
                    borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
                  ),
                  child: Icon(
                    Icons.lock_person_outlined,
                    color: isDark ? WellnessColors.darkPrimary : Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                Text(
                  WellnessConstants.privacyHeroTitle,
                  style: WellnessTextStyles.display(
                    color: isDark ? WellnessColors.darkTextPrimary : Colors.white,
                  ).copyWith(fontSize: 26),
                ),
                const SizedBox(height: WellnessSpacing.sm),
                Text(
                  WellnessConstants.privacyHeroSubtitle,
                  style: WellnessTextStyles.body.copyWith(
                    color: isDark
                        ? WellnessColors.darkTextSecondary
                        : Colors.white.withValues(alpha: 0.92),
                    fontSize: 15,
                    height: 1.5,
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
          color: isDark ? WellnessColors.darkAccent : Colors.white.withValues(alpha: 0.95),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: WellnessTextStyles.body.copyWith(
              color: isDark ? WellnessColors.darkTextSecondary : Colors.white.withValues(alpha: 0.9),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
