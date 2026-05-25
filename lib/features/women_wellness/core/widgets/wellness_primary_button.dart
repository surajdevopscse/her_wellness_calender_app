import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Primary wellness button.
class WellnessPrimaryButton extends StatelessWidget {
  const WellnessPrimaryButton({
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, WellnessSpacing.minTouchTarget),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
        ),
      ),
      child: child,
    );
  }
}
