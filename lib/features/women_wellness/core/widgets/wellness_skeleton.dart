import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/app_radius.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Lightweight shimmer-style skeleton used in loading states.
class WellnessSkeleton extends StatefulWidget {
  const WellnessSkeleton({
    super.key,
    required this.height,
    this.width = double.infinity,
  });

  final double height;
  final double width;

  @override
  State<WellnessSkeleton> createState() => _WellnessSkeletonState();
}

class _WellnessSkeletonState extends State<WellnessSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final base = brightness == Brightness.dark
        ? WellnessColors.darkSurface.withValues(alpha: 0.72)
        : WellnessColors.blush.withValues(alpha: 0.82);
    final highlight = brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.7);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            gradient: LinearGradient(
              begin: Alignment(-1.2 + (_controller.value * 2.4), -0.2),
              end: Alignment(0.2 + (_controller.value * 2.4), 0.2),
              colors: [base, highlight, base],
              stops: const [0.1, 0.45, 0.9],
            ),
          ),
        );
      },
    );
  }
}
