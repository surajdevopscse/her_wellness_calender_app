import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

/// Circular wellness score indicator for dashboard.
class WellnessScoreRing extends StatelessWidget {
  const WellnessScoreRing({
    super.key,
    required this.score,
    this.size = 72,
  });

  final int score;
  final double size;

  @override
  Widget build(BuildContext context) {
    final clamped = score.clamp(0, 100);
    final progress = clamped / 100;
    final color = _colorForScore(clamped);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 6,
              backgroundColor: WellnessColors.border.withValues(alpha: 0.5),
              color: color,
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$clamped',
                style: WellnessTextStyles.statNumber(color: color).copyWith(
                  fontSize: size * 0.28,
                ),
              ),
              Text(
                'score',
                style: WellnessTextStyles.captionStatic.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _colorForScore(int value) {
    if (value >= 75) return WellnessColors.secondary;
    if (value >= 50) return WellnessColors.primary;
    return WellnessColors.pms;
  }
}
