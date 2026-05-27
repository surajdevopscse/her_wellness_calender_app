import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/app_decorations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/app_radius.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

/// Stable desktop sidebar without NavigationRail auto-scroll behavior.
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
    return Container(
      width: 248,
      decoration: AppDecorations.softPanel(
        brightness,
      ).copyWith(borderRadius: BorderRadius.circular(AppRadius.lg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wellness',
                  style: WellnessTextStyles.sectionHeader(
                    brightness,
                  ).copyWith(fontSize: 24),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your daily cycle space',
                  style: WellnessTextStyles.caption(context),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: WellnessColors.borderFor(brightness).withValues(alpha: 0.5),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(14),
              itemCount: _destinations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final destination = _destinations[index];
                final selected = index == selectedIndex;
                return _RailTile(
                  icon: destination.$1,
                  label: destination.$2,
                  selected: selected,
                  onTap: () => onSelected(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RailTile extends StatelessWidget {
  const _RailTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final selectedBackground = brightness == Brightness.dark
        ? WellnessColors.darkPrimary.withValues(alpha: 0.18)
        : WellnessColors.secondary.withValues(alpha: 0.55);
    final selectedForeground = brightness == Brightness.dark
        ? WellnessColors.darkPrimary
        : WellnessColors.primaryDeep;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? selectedBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: selected
                  ? selectedForeground.withValues(alpha: 0.18)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: selected
                    ? selectedForeground
                    : WellnessColors.textSecondaryFor(brightness),
              ),
              const SizedBox(width: WellnessSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: selected
                        ? WellnessColors.textPrimaryFor(brightness)
                        : WellnessColors.textSecondaryFor(brightness),
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
