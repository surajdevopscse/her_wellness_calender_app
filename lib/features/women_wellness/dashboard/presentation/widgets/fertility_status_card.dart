import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/wellness_score_ring.dart';

/// Fertility status and wellness score for dashboard grid.
class FertilityStatusCard extends StatelessWidget {
  const FertilityStatusCard({super.key, required this.prediction});

  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final inFertile = _isInFertileWindow(prediction);
    final score = _wellnessScore(prediction);

    return FadeInContainer(
      delay: const Duration(milliseconds: 100),
      child: WellnessGlassCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fertility status',
                    style: WellnessTextStyles.sectionHeader(brightness),
                  ),
                  const SizedBox(height: WellnessSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        inFertile ? Icons.eco_outlined : Icons.nightlight_outlined,
                        color: inFertile ? WellnessColors.fertileDeep : WellnessColors.textMuted,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          inFertile
                              ? 'You may be in your fertile window'
                              : 'Outside fertile window',
                          style: WellnessTextStyles.bodyForBrightness(brightness),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: WellnessSpacing.md),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(WellnessSpacing.pillRadius),
                    child: LinearProgressIndicator(
                      value: (prediction.currentCycleDay / 28).clamp(0.05, 1.0),
                      minHeight: 8,
                      backgroundColor: WellnessColors.border.withValues(alpha: 0.4),
                      color: inFertile ? WellnessColors.fertileDeep : WellnessColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: WellnessSpacing.md),
            WellnessScoreRing(score: score),
          ],
        ),
      ),
    );
  }

  bool _isInFertileWindow(CyclePrediction p) {
    final now = DateTime.now();
    return !now.isBefore(p.fertileWindowStart) && !now.isAfter(p.fertileWindowEnd);
  }

  int _wellnessScore(CyclePrediction p) {
    final day = p.currentCycleDay;
    if (day <= 5) return 62;
    if (day <= 13) return 78;
    if (day <= 16) return 85;
    if (day <= 24) return 72;
    return 68;
  }
}
