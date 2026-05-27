import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/app_radius.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/app_shadows.dart';
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
    final base =
        tint ?? (isDark ? WellnessColors.darkCard : WellnessColors.surface);
    final radius = AppRadius.lg + 4;
    final textColor = WellnessColors.textPrimaryFor(brightness);

    final content = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: WellnessColors.borderFor(brightness).withValues(alpha: 0.72),
            width: 1,
          ),
          boxShadow: AppShadows.soft(brightness),
        ),
        padding: padding ?? const EdgeInsets.all(WellnessSpacing.xl),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: textColor, decoration: TextDecoration.none),
          child: IconTheme.merge(
            data: IconThemeData(color: WellnessColors.primaryDeep),
            child: child,
          ),
        ),
      ),
    );

    final surface = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: content,
    );

    if (onTap == null) return surface;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: surface,
      ),
    );
  }
}
