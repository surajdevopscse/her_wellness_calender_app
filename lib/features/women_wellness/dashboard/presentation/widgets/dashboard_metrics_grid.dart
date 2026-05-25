import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Responsive dashboard grid — cards size to content (no fixed aspect ratio).
class DashboardMetricsGrid extends StatelessWidget {
  const DashboardMetricsGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = WellnessResponsive.dashboardColumns(context);
        if (columns <= 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: WellnessSpacing.lg),
                children[i],
              ],
            ],
          );
        }

        final gap = WellnessSpacing.lg;
        final cardWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(
                width: cardWidth,
                child: child,
              ),
          ],
        );
      },
    );
  }
}
