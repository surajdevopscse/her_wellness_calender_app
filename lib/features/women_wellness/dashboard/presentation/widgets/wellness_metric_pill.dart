import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Compact polished metric pill for dashboard hero.
class WellnessMetricPill extends StatelessWidget {
  const WellnessMetricPill({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.expand = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final fg = WellnessColors.textPrimaryFor(brightness);
    final fgMuted = WellnessColors.textSecondaryFor(brightness);
    final bg = isDark
        ? WellnessColors.darkSurface
        : WellnessColors.secondary.withValues(alpha: 0.34);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: expand ? double.infinity : 0,
        maxWidth: expand ? double.infinity : 320,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: WellnessColors.borderFor(brightness).withValues(alpha: 0.8),
          ),
        ),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(icon, color: fg, size: 18),
            ),
            const SizedBox(width: WellnessSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: fgMuted, fontSize: 11),
                  ),
                  Text(
                    value,
                    maxLines: expand ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: fg,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            if (!expand) const SizedBox(width: WellnessSpacing.xs),
          ],
        ),
      ),
    );
  }
}
