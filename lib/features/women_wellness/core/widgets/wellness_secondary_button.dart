import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Secondary wellness button.
class WellnessSecondaryButton extends StatelessWidget {
  const WellnessSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final child = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: WellnessSpacing.iconSize),
              const SizedBox(width: WellnessSpacing.sm),
              Flexible(child: Text(label)),
            ],
          );
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, WellnessSpacing.minTouchTarget),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
        ),
      ),
      child: child,
    );
  }
}
