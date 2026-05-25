import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_blur_container.dart';

/// Reusable premium wellness card.
class WellnessCard extends StatelessWidget {
  const WellnessCard({
    super.key,
    required this.child,
    this.padding,
    this.gradient,
    this.color,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final card = WellnessBlurContainer(
      color: gradient == null
          ? color ??
              (brightness == Brightness.dark
                  ? WellnessColors.darkCard.withValues(alpha: 0.52)
                  : Colors.white.withValues(alpha: 0.78))
          : null,
      gradient: gradient,
      padding: padding ?? const EdgeInsets.all(WellnessSpacing.xl),
      child: child,
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(WellnessSpacing.cardRadius + 4),
        child: card,
      ),
    );
  }
}
