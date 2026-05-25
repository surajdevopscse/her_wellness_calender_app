import 'package:flutter/widgets.dart';

/// Responsive breakpoint helper for mobile, tablet, desktop, and web.
class WellnessResponsive {
  WellnessResponsive._();

  static const mobileBreakpoint = 600.0;
  static const tabletBreakpoint = 1024.0;
  static const desktopBreakpoint = 1440.0;
  static const comfortableContentBreakpoint = 760.0;
  static const onboardingWideBreakpoint = 720.0;

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static bool isMobile(BuildContext context) =>
      width(context) < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final value = width(context);
    return value >= mobileBreakpoint && value < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      width(context) >= tabletBreakpoint;

  static bool isLargeDesktop(BuildContext context) =>
      width(context) >= desktopBreakpoint;

  static bool isPortrait(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.portrait;

  static EdgeInsets pagePadding(BuildContext context) {
    if (isLargeDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 28);
    }
    if (isTablet(context) || isDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 28, vertical: 24);
    }
    return const EdgeInsets.all(16);
  }

  static double bottomContentInset(BuildContext context) =>
      isMobile(context) ? 110 : 24;

  static double contentMaxWidth(BuildContext context) {
    if (isLargeDesktop(context)) return 1320;
    if (isDesktop(context)) return 1180;
    if (isTablet(context)) return 820;
    return double.infinity;
  }

  static bool useComfortableColumns(BuildContext context, double maxWidth) =>
      maxWidth >= comfortableContentBreakpoint;

  static bool useWideOnboarding(double maxWidth) =>
      maxWidth > onboardingWideBreakpoint;

  static double adaptiveFieldWidth(BuildContext context, double maxWidth) {
    if (isLargeDesktop(context)) return 320;
    if (isDesktop(context)) return 300;
    if (isTablet(context)) return ((maxWidth - 16) / 2).clamp(240, 320);
    return double.infinity;
  }

  static int dashboardColumns(BuildContext context) {
    if (isLargeDesktop(context)) return 4;
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }

  static int calendarColumns(BuildContext context) {
    if (isDesktop(context)) return 2;
    return 1;
  }
}
