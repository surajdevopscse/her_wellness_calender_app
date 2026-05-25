import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Layered ambient background used across wellness surfaces.
class WellnessBackground extends StatelessWidget {
  const WellnessBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: WellnessColors.backgroundGradientFor(brightness),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -40,
            child: _Glow(
              size: 280,
              color: WellnessColors.glowLavender.withValues(
                alpha: isDark ? 0.14 : 0.32,
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -90,
            child: _Glow(
              size: 220,
              color: WellnessColors.glowRose.withValues(
                alpha: isDark ? 0.12 : 0.26,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -40,
            child: _Glow(
              size: 260,
              color: WellnessColors.glowPeach.withValues(
                alpha: isDark ? 0.08 : 0.24,
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _TexturePainter(
                  opacity: isDark ? 0.018 : 0.028,
                  dark: isDark,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _TexturePainter extends CustomPainter {
  const _TexturePainter({required this.opacity, required this.dark});

  final double opacity;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (dark ? Colors.white : Colors.black).withValues(alpha: opacity);
    for (double x = 0; x < size.width; x += 18) {
      for (double y = 0; y < size.height; y += 18) {
        final radius = ((x + y) % 3 == 0) ? 0.7 : 0.45;
        canvas.drawCircle(Offset(x + math.sin(y) * 0.8, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TexturePainter oldDelegate) =>
      oldDelegate.opacity != opacity || oldDelegate.dark != dark;
}
