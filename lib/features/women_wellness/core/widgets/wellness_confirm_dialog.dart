import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Confirmation dialog for destructive wellness actions.
class WellnessConfirmDialog extends StatelessWidget {
  const WellnessConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WellnessSpacing.sheetRadius),
      ),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(WellnessConstants.cancel),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: const Text(WellnessConstants.confirm),
        ),
      ],
    );
  }
}
