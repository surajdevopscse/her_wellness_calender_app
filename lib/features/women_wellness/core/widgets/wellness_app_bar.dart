import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
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
    final width = WellnessResponsive.width(context);
    final isCompact = width < 360;
    final hideSubtitle = width < 430;
    return AppBar(
      titleSpacing: isCompact ? 10 : 18,
      toolbarHeight: hideSubtitle ? 64 : 82,
      title: Row(
        children: [
          Container(
            width: isCompact ? 38 : 44,
            height: isCompact ? 38 : 44,
            decoration: BoxDecoration(
              color: WellnessColors.surface.withValues(alpha: 0.92),
              shape: BoxShape.circle,
              border: Border.all(
                color: WellnessColors.primaryDeep.withValues(alpha: 0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: WellnessColors.primaryDeep.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.spa_rounded,
              size: 20,
              color: WellnessColors.primaryDeep,
            ),
          ),
          const SizedBox(width: WellnessSpacing.md),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: WellnessTextStyles.appTitle(brightness).copyWith(
                    fontSize: hideSubtitle ? 17 : (isCompact ? 18 : 24),
                    height: 1,
                  ),
                ),
                if (!hideSubtitle) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Cycle care, daily notes, and gentle insights',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: WellnessTextStyles.caption(
                      context,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      centerTitle: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: isDark
              ? WellnessColors.darkBackground.withValues(alpha: 0.94)
              : WellnessColors.surface.withValues(alpha: 0.96),
          border: Border(
            bottom: BorderSide(
              color: WellnessColors.borderFor(
                brightness,
              ).withValues(alpha: 0.55),
            ),
          ),
        ),
      ),
      backgroundColor: isDark
          ? WellnessColors.darkBackground.withValues(alpha: 0.94)
          : WellnessColors.surface.withValues(alpha: 0.96),
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82);
}
