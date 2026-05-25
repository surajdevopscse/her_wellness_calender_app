import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

class WellnessBlurContainer extends StatelessWidget {
  const WellnessBlurContainer({
    super.key,
    required this.child,
    this.padding,
    this.radius,
    this.color,
    this.borderColor,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final resolvedRadius = radius ?? WellnessSpacing.cardRadius + 4;

    return ClipRRect(
      borderRadius: BorderRadius.circular(resolvedRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding ?? const EdgeInsets.all(WellnessSpacing.xl),
          decoration: BoxDecoration(
            color: gradient == null
                ? color ??
                    (isDark
                        ? WellnessColors.darkCard.withValues(alpha: 0.52)
                        : Colors.white.withValues(alpha: 0.72))
                : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(resolvedRadius),
            border: Border.all(
              color: borderColor ??
                  (isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.66)),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.18)
                    : WellnessColors.primary.withValues(alpha: 0.09),
                blurRadius: 30,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
