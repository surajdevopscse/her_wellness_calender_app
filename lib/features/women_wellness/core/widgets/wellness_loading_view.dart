import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_skeleton.dart';

/// Standard premium loading view with soft glow ring.
class WellnessLoadingView extends StatefulWidget {
  const WellnessLoadingView({super.key, this.message});

  final String? message;

  @override
  State<WellnessLoadingView> createState() => _WellnessLoadingViewState();
}

class _WellnessLoadingViewState extends State<WellnessLoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WellnessGlassCard(
        padding: const EdgeInsets.symmetric(
          horizontal: WellnessSpacing.xl,
          vertical: WellnessSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  size: const Size.square(70),
                  painter: _LoaderPainter(turns: _controller.value),
                );
              },
            ),
            const SizedBox(height: WellnessSpacing.md),
            Text(
              widget.message ?? WellnessConstants.loading,
              textAlign: TextAlign.center,
              style: WellnessTextStyles.caption(context),
            ),
            const SizedBox(height: WellnessSpacing.lg),
            const WellnessSkeleton(height: 12, width: 180),
            const SizedBox(height: WellnessSpacing.sm),
            const WellnessSkeleton(height: 12, width: 120),
          ],
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  const _LoaderPainter({required this.turns});

  final double turns;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.6;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          WellnessColors.primaryHot,
          WellnessColors.secondary,
          WellnessColors.accent,
          WellnessColors.primaryDeep,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      turns * math.pi * 2,
      math.pi * 1.35,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _LoaderPainter oldDelegate) =>
      oldDelegate.turns != turns;
}
