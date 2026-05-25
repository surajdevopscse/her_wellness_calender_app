import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Frosted glass card for premium wellness surfaces.
class WellnessGlassCard extends StatelessWidget {
  const WellnessGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.tint,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final base = tint ??
        (isDark
            ? WellnessColors.darkCard.withValues(alpha: 0.46)
            : Colors.white.withValues(alpha: 0.62));

    final content = ClipRRect(
      borderRadius: BorderRadius.circular(WellnessSpacing.cardRadius + 4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(WellnessSpacing.cardRadius + 4),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.76),
              width: 1.1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      WellnessColors.darkCard.withValues(alpha: 0.65),
                      WellnessColors.darkSurface.withValues(alpha: 0.48),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.82),
                      WellnessColors.blush.withValues(alpha: 0.45),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.15)
                    : WellnessColors.primary.withValues(alpha: 0.08),
                blurRadius: 26,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          padding: padding ?? const EdgeInsets.all(WellnessSpacing.xl),
          child: child,
        ),
      ),
    );

    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(WellnessSpacing.cardRadius + 4),
        child: content,
      ),
    );
  }
}
