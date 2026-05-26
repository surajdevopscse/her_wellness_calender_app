import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

/// Reusable module app bar with premium translucent header treatment.
class WellnessAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WellnessAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final isCompact = WellnessResponsive.width(context) < 360;
    return AppBar(
      titleSpacing: isCompact ? 12 : 20,
      toolbarHeight: isCompact ? 64 : 74,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: WellnessTextStyles.appTitle(brightness).copyWith(
              fontSize: isCompact ? 18 : null,
            ),
          ),
          if (!isCompact)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.white.withValues(alpha: 0.62),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : WellnessColors.borderFor(brightness)
                          .withValues(alpha: 0.6),
                ),
              ),
              child: Text(
                'Private cycle insights',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: WellnessTextStyles.caption(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      centerTitle: false,
      backgroundColor: isDark
          ? WellnessColors.darkBackground.withValues(alpha: 0.22)
          : Colors.white.withValues(alpha: 0.08),
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(74);
}
