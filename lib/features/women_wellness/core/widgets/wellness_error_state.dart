import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';

/// Standard error state with retry action.
class WellnessErrorState extends StatelessWidget {
  const WellnessErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

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
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: WellnessColors.error.withValues(alpha: 0.12),
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 34,
                    color: WellnessColors.error,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.md),
                Text(
                  'Something needs attention',
                  textAlign: TextAlign.center,
                  style: WellnessTextStyles.sectionHeader(brightness)
                      .copyWith(fontSize: 24),
                ),
                const SizedBox(height: WellnessSpacing.sm),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: WellnessTextStyles.body.copyWith(
                    color: WellnessColors.textPrimaryFor(brightness),
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                OutlinedButton(
                  onPressed: onRetry,
                  child: const Text(WellnessConstants.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
