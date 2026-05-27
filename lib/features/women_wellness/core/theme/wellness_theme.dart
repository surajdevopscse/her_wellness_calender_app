import 'package:flutter/material.dart';

import 'app_radius.dart';
import 'wellness_colors.dart';
import 'wellness_spacing.dart';
import 'wellness_text_styles.dart';

/// Material theme for premium wellness surfaces.
class WellnessTheme {
  WellnessTheme._();

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = isDark
        ? WellnessColors.darkScheme
        : WellnessColors.lightScheme;
    final textTheme = WellnessTextStyles.textTheme(brightness);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: WellnessColors.backgroundFor(brightness),
      canvasColor: Colors.transparent,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: WellnessTextStyles.appTitle(brightness),
        iconTheme: IconThemeData(
          color: WellnessColors.textPrimaryFor(brightness),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: WellnessColors.cardFor(
          brightness,
        ).withValues(alpha: isDark ? 0.64 : 0.82),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WellnessSpacing.cardRadius + 4),
          side: BorderSide(
            color: WellnessColors.borderFor(brightness).withValues(alpha: 0.55),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: WellnessColors.borderFor(brightness).withValues(alpha: 0.45),
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark
              ? WellnessColors.darkPrimary
              : WellnessColors.primaryDeep,
          foregroundColor: isDark
              ? WellnessColors.darkTextOnPrimary
              : Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(0, WellnessSpacing.minTouchTarget + 4),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              WellnessSpacing.controlRadius + 2,
            ),
          ),
          textStyle: WellnessTextStyles.button(brightness),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: isDark
              ? WellnessColors.darkPrimary
              : WellnessColors.primaryDeep,
          foregroundColor: isDark
              ? WellnessColors.darkTextOnPrimary
              : Colors.white,
          disabledBackgroundColor: WellnessColors.borderFor(
            brightness,
          ).withValues(alpha: 0.55),
          disabledForegroundColor: WellnessColors.textMuted,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(0, WellnessSpacing.minTouchTarget + 2),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              WellnessSpacing.controlRadius + 2,
            ),
          ),
          textStyle: WellnessTextStyles.button(brightness),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark
              ? WellnessColors.darkPrimary
              : WellnessColors.primaryDeep,
          side: BorderSide(
            color: isDark
                ? WellnessColors.darkPrimary.withValues(alpha: 0.55)
                : WellnessColors.primaryDeep.withValues(alpha: 0.4),
          ),
          minimumSize: const Size(0, WellnessSpacing.minTouchTarget + 4),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              WellnessSpacing.controlRadius + 2,
            ),
          ),
          textStyle: WellnessTextStyles.button(brightness),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark
              ? WellnessColors.darkPrimary
              : WellnessColors.primaryDeep,
          minimumSize: const Size(
            WellnessSpacing.minTouchTarget,
            WellnessSpacing.minTouchTarget,
          ),
          textStyle: WellnessTextStyles.button(brightness),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? WellnessColors.darkSurface.withValues(alpha: 0.7)
            : WellnessColors.surface.withValues(alpha: 0.9),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            WellnessSpacing.controlRadius + 2,
          ),
          borderSide: BorderSide(
            color: WellnessColors.borderFor(brightness).withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            WellnessSpacing.controlRadius + 2,
          ),
          borderSide: BorderSide(
            color: WellnessColors.borderFor(brightness).withValues(alpha: 0.45),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            WellnessSpacing.controlRadius + 2,
          ),
          borderSide: BorderSide(
            color: isDark
                ? WellnessColors.darkPrimary
                : WellnessColors.primaryDeep,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            WellnessSpacing.controlRadius + 2,
          ),
          borderSide: const BorderSide(color: WellnessColors.error),
        ),
        labelStyle: WellnessTextStyles.label.copyWith(
          color: WellnessColors.textSecondaryFor(brightness),
        ),
        hintStyle: WellnessTextStyles.body.copyWith(
          color: WellnessColors.textMuted,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? WellnessColors.darkSurface.withValues(alpha: 0.7)
            : WellnessColors.secondary.withValues(alpha: 0.38),
        selectedColor: isDark
            ? WellnessColors.darkPrimary.withValues(alpha: 0.35)
            : WellnessColors.primaryHot.withValues(alpha: 0.7),
        labelStyle: WellnessTextStyles.label,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            WellnessSpacing.controlRadius + 4,
          ),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: WellnessColors.cardFor(brightness),
        indicatorColor: WellnessColors.secondary.withValues(alpha: 0.55),
        labelTextStyle: WidgetStatePropertyAll(
          WellnessTextStyles.captionStatic.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark
            ? WellnessColors.darkCard
            : WellnessColors.textPrimary,
        contentTextStyle: WellnessTextStyles.body.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: WellnessColors.cardFor(brightness),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        titleTextStyle: WellnessTextStyles.sectionHeader(brightness),
        contentTextStyle: WellnessTextStyles.bodyForBrightness(brightness),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDark
            ? WellnessColors.darkPrimary
            : WellnessColors.primaryHot,
        foregroundColor: isDark
            ? WellnessColors.darkTextOnPrimary
            : Colors.white,
        elevation: 0,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 18),
      ),
      listTileTheme: ListTileThemeData(
        minVerticalPadding: 10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        titleTextStyle: WellnessTextStyles.section.copyWith(
          color: WellnessColors.textPrimaryFor(brightness),
        ),
        subtitleTextStyle: WellnessTextStyles.body.copyWith(
          color: WellnessColors.textSecondaryFor(brightness),
        ),
      ),
      iconTheme: IconThemeData(
        color: WellnessColors.textSecondaryFor(brightness),
        size: WellnessSpacing.iconSize,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return isDark ? WellnessColors.darkTextOnPrimary : Colors.white;
          }
          return isDark
              ? WellnessColors.darkTextMuted
              : WellnessColors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return isDark
                ? WellnessColors.darkPrimary.withValues(alpha: 0.85)
                : WellnessColors.primaryDeep;
          }
          return isDark ? WellnessColors.darkBorder : WellnessColors.border;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return isDark
                ? WellnessColors.darkPrimary
                : WellnessColors.primaryDeep;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStatePropertyAll(
          isDark ? WellnessColors.darkTextOnPrimary : Colors.white,
        ),
        side: BorderSide(
          color: WellnessColors.borderFor(brightness),
          width: 1.4,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      extensions: const [WellnessThemeExtension()],
    );
  }
}

/// Theme extension hook for future semantic tokens.
class WellnessThemeExtension extends ThemeExtension<WellnessThemeExtension> {
  const WellnessThemeExtension();

  @override
  WellnessThemeExtension copyWith() => const WellnessThemeExtension();

  @override
  WellnessThemeExtension lerp(
    covariant ThemeExtension<WellnessThemeExtension>? other,
    double t,
  ) => const WellnessThemeExtension();
}
