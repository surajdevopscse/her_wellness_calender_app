import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_background.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_blur_container.dart';

/// Responsive auth layout with an emotional hero panel and glass form surface.
class AuthShellLayout extends StatelessWidget {
  const AuthShellLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.heroIcon = Icons.favorite_rounded,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final IconData heroIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WellnessBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(WellnessSpacing.xl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: WellnessSpacing.authMaxWidth,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = WellnessResponsive.useWideOnboarding(
                      constraints.maxWidth,
                    );
                    return isWide
                        ? _wideLayout(context)
                        : _narrowLayout(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wideLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 11, child: _heroPanel(context)),
          const SizedBox(width: WellnessSpacing.xl),
          Expanded(flex: 9, child: _formCard(context)),
        ],
      ),
    );
  }

  Widget _narrowLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _heroPanel(context, compact: true),
        const SizedBox(height: WellnessSpacing.lg),
        _formCard(context),
      ],
    );
  }

  Widget _heroPanel(BuildContext context, {bool compact = false}) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    return Stack(
      children: [
        WellnessBlurContainer(
          radius: 34,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: WellnessColors.heroGradientFor(brightness),
          ),
          padding: EdgeInsets.all(compact ? WellnessSpacing.xl : 36),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: compact
                  ? WellnessSpacing.heroCompactMinHeight
                  : WellnessSpacing.heroWideMinHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: compact ? 58 : WellnessSpacing.largeIconBox + 14,
                  height: compact ? 58 : WellnessSpacing.largeIconBox + 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.55),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                    ),
                  ),
                  child: Icon(
                    heroIcon,
                    size: compact ? 28 : 34,
                    color: WellnessColors.primaryDeep,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.xl),
                Text(
                  title,
                  style: WellnessTextStyles.display(
                    color: WellnessColors.textPrimaryFor(brightness),
                  ).copyWith(fontSize: compact ? 34 : 50),
                ),
                const SizedBox(height: WellnessSpacing.md),
                Text(
                  subtitle,
                  style: WellnessTextStyles.body.copyWith(
                    color: WellnessColors.textSecondaryFor(brightness),
                    fontSize: compact ? 15 : 16,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.xl),
                Wrap(
                  spacing: WellnessSpacing.md,
                  runSpacing: WellnessSpacing.md,
                  children: const [
                    _HeroPoint(
                      icon: Icons.lock_outline_rounded,
                      text: 'Private and secure tracking',
                    ),
                    _HeroPoint(
                      icon: Icons.auto_awesome_rounded,
                      text: 'Personalized cycle insights',
                    ),
                    _HeroPoint(
                      icon: Icons.favorite_outline_rounded,
                      text: 'Gentle support for every phase',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 26,
          top: 26,
          child: Container(
            width: compact ? 96 : 130,
            height: compact ? 96 : 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: WellnessColors.glowLavender.withValues(alpha: 0.24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _formCard(BuildContext context) {
    return WellnessBlurContainer(
      radius: 34,
      padding: const EdgeInsets.all(WellnessSpacing.xl),
      child: child,
    );
  }
}

class _HeroPoint extends StatelessWidget {
  const _HeroPoint({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WellnessSpacing.md,
        vertical: WellnessSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: WellnessColors.primaryDeep),
          const SizedBox(width: 8),
          Text(text, style: WellnessTextStyles.caption(context)),
        ],
      ),
    );
  }
}
