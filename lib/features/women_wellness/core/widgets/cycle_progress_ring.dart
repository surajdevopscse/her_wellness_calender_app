import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

class CycleProgressRing extends StatelessWidget {
  const CycleProgressRing({
    super.key,
    required this.day,
    required this.totalDays,
    this.label = 'Cycle Day',
    this.size = 166,
  });

  final int day;
  final int totalDays;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final progress = (day / totalDays).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: _RingPainter(progress: progress, dark: brightness == Brightness.dark),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$day',
                style: WellnessTextStyles.heroNumber(
                  color: WellnessColors.textPrimaryFor(brightness),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: WellnessTextStyles.caption(context).copyWith(
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress, required this.dark});

  final double progress;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 14.0;
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;

    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke
      ..color = (dark ? Colors.white : WellnessColors.primaryDeep)
          .withValues(alpha: 0.12);

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke
      ..shader = SweepGradient(
        colors: const [
          WellnessColors.primaryHot,
          WellnessColors.secondary,
          WellnessColors.accent,
          WellnessColors.primaryDeep,
        ],
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    final halo = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke + 8
      ..color = WellnessColors.primaryHot.withValues(alpha: dark ? 0.1 : 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.drawCircle(center, radius, base);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      halo,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.dark != dark;
}
