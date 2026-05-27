import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';

/// Shared responsive container to keep wide layouts from stretching.
class WellnessPageContainer extends StatelessWidget {
  const WellnessPageContainer({
    super.key,
    required this.child,
    this.maxWidth,
  });

  final Widget child;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? WellnessResponsive.contentMaxWidth(context),
        ),
        child: Padding(
          padding: WellnessResponsive.pagePadding(context),
          child: child,
        ),
      ),
    );
  }
}
