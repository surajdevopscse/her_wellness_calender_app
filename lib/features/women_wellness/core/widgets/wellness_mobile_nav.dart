import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_blur_container.dart';

/// Floating glass navigation for the wellness mobile shell.
class WellnessMobileNav extends StatelessWidget {
  const WellnessMobileNav({
    super.key,
    required this.selectedPageIndex,
    required this.onSelected,
  });

  final int selectedPageIndex;
  final ValueChanged<int> onSelected;

  static const _items = [
    (Icons.home_rounded, 'Home', 0),
    (Icons.calendar_month_rounded, 'Calendar', 1),
    (Icons.edit_note_rounded, 'Check-in', 3),
    (Icons.insights_rounded, 'Reports', 5),
    (Icons.tune_rounded, 'Settings', 9),
  ];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return WellnessBlurContainer(
      radius: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: isDark
          ? WellnessColors.darkCard.withValues(alpha: 0.56)
          : Colors.white.withValues(alpha: 0.72),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _items.map((item) {
          final selected = selectedPageIndex == item.$3;
          final prominent = item.$3 == 3;
          return _MobileNavItem(
            icon: item.$1,
            label: item.$2,
            selected: selected,
            prominent: prominent,
            onTap: () => onSelected(item.$3),
          );
        }).toList(),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.prominent,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool prominent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final activeColor = prominent
        ? WellnessColors.textOnPrimary
        : WellnessColors.primaryDeep;
    final inactiveColor = WellnessColors.textSecondaryFor(brightness);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: EdgeInsets.symmetric(
            vertical: prominent ? 4 : 8,
            horizontal: prominent ? 0 : 6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                width: prominent ? 52 : (selected ? 44 : 38),
                height: prominent ? 52 : 38,
                decoration: BoxDecoration(
                  gradient: prominent
                      ? const LinearGradient(
                          colors: [
                            WellnessColors.primaryHot,
                            WellnessColors.secondary,
                          ],
                        )
                      : selected
                          ? LinearGradient(
                              colors: [
                                WellnessColors.primaryHot.withValues(alpha: 0.78),
                                WellnessColors.peach.withValues(alpha: 0.5),
                              ],
                            )
                          : null,
                  color: !prominent && !selected
                      ? Colors.white.withValues(alpha: 0.04)
                      : null,
                  borderRadius: BorderRadius.circular(prominent ? 18 : 16),
                  boxShadow: selected || prominent
                      ? [
                          BoxShadow(
                            color: WellnessColors.primaryHot.withValues(alpha: 0.22),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : const [],
                ),
                child: Icon(
                  icon,
                  color: selected || prominent ? activeColor : inactiveColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: WellnessTextStyles.caption(context).copyWith(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? WellnessColors.primaryDeep : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
