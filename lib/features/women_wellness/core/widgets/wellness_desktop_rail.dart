import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Theme-aware desktop navigation rail for the wellness shell.
class WellnessDesktopRail extends StatelessWidget {
  const WellnessDesktopRail({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _destinations = [
    (Icons.dashboard_rounded, 'Dashboard'),
    (Icons.calendar_month_rounded, 'Calendar'),
    (Icons.edit_calendar_rounded, 'Period'),
    (Icons.today_rounded, 'Daily Log'),
    (Icons.checklist_rounded, 'Symptoms'),
    (Icons.bar_chart_rounded, 'Reports'),
    (Icons.history_rounded, 'History'),
    (Icons.notifications_rounded, 'Reminders'),
    (Icons.lock_rounded, 'Privacy'),
    (Icons.settings_rounded, 'Settings'),
    (Icons.insights_rounded, 'Insights'),
    (Icons.picture_as_pdf_rounded, 'PDF'),
  ];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final surface = isDark
        ? WellnessColors.darkCard.withValues(alpha: 0.92)
        : WellnessColors.card.withValues(alpha: 0.9);
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.35)
        : WellnessColors.primary.withValues(alpha: 0.14);

    return Container(
      width: 104,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(WellnessSpacing.cardRadius),
        border: Border.all(
          color: WellnessColors.borderFor(brightness).withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: NavigationRail(
        backgroundColor: Colors.transparent,
        selectedIndex: selectedIndex,
        onDestinationSelected: onSelected,
        scrollable: true,
        labelType: NavigationRailLabelType.none,
        indicatorColor: isDark
            ? WellnessColors.darkPrimary.withValues(alpha: 0.35)
            : WellnessColors.primaryHot.withValues(alpha: 0.45),
        selectedIconTheme: IconThemeData(
          color: isDark ? WellnessColors.darkPrimary : WellnessColors.primaryDeep,
          size: 24,
        ),
        unselectedIconTheme: IconThemeData(
          color: WellnessColors.textSecondaryFor(brightness),
          size: 22,
        ),
        destinations: [
          for (final d in _destinations)
            NavigationRailDestination(
              icon: Icon(d.$1),
              label: Text(d.$2),
            ),
        ],
      ),
    );
  }
}
