import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/app_radius.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_blur_container.dart';

/// Reusable premium wellness card with subtle hover feedback on desktop/web.
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
    final textColor = WellnessColors.textPrimaryFor(brightness);
    return _InteractiveWellnessCard(
      onTap: onTap,
      child: WellnessBlurContainer(
        color: gradient == null
            ? color ??
                  (brightness == Brightness.dark
                      ? WellnessColors.darkCard.withValues(alpha: 0.62)
                      : WellnessColors.surface.withValues(alpha: 0.92))
            : null,
        gradient: null,
        padding: padding ?? const EdgeInsets.all(WellnessSpacing.xl),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: textColor, decoration: TextDecoration.none),
          child: IconTheme.merge(
            data: IconThemeData(
              color: WellnessColors.textSecondaryFor(brightness),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _InteractiveWellnessCard extends StatefulWidget {
  const _InteractiveWellnessCard({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_InteractiveWellnessCard> createState() =>
      _InteractiveWellnessCardState();
}

class _InteractiveWellnessCardState extends State<_InteractiveWellnessCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final canHover = WellnessResponsive.isDesktop(context);
    final content = AnimatedScale(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      scale: _hovered && widget.onTap != null ? 1.01 : 1,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        offset: _hovered && widget.onTap != null
            ? const Offset(0, -0.01)
            : Offset.zero,
        child: widget.child,
      ),
    );

    final surface = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg + 4),
      child: content,
    );

    final interactive = widget.onTap == null
        ? surface
        : Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(AppRadius.lg + 4),
              child: surface,
            ),
          );

    if (!canHover) {
      return interactive;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: interactive,
    );
  }
}
