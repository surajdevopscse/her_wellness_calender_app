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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? WellnessColors.darkTextPrimary : Colors.white;
    final fgMuted = isDark ? WellnessColors.darkTextSecondary : Colors.white70;
    final bg = isDark
        ? WellnessColors.darkPrimary.withValues(alpha: 0.18)
        : Colors.white.withValues(alpha: 0.22);

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
            color: (isDark ? WellnessColors.darkBorder : Colors.white)
                .withValues(alpha: 0.35),
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
