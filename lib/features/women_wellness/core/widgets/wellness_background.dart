import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Layered ambient background used across wellness surfaces.
class WellnessBackground extends StatelessWidget {
  const WellnessBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: WellnessColors.backgroundGradientFor(brightness),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _TexturePainter(
                  opacity: brightness == Brightness.dark ? 0.015 : 0.018,
                  dark: brightness == Brightness.dark,
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

class _TexturePainter extends CustomPainter {
  const _TexturePainter({required this.opacity, required this.dark});

  final double opacity;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (dark ? Colors.white : Colors.black).withValues(alpha: opacity);
    for (double x = 0; x < size.width; x += 24) {
      for (double y = 0; y < size.height; y += 24) {
        canvas.drawCircle(Offset(x, y), 0.45, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TexturePainter oldDelegate) =>
      oldDelegate.opacity != opacity || oldDelegate.dark != dark;
}
