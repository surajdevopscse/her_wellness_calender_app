import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_background.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_blur_container.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/presentation/controllers/onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final screenSize = MediaQuery.sizeOf(context);
    final compactViewport = screenSize.height < 760;
    final outerPadding = compactViewport
        ? WellnessSpacing.md
        : WellnessSpacing.xl;

    if (screenSize.width < WellnessResponsive.mobileBreakpoint) {
      return _MobileOnboardingView(
        controller: controller,
        iconFor: _iconFor,
        pointsForSlide: _pointsForSlide,
      );
    }

    return Scaffold(
      body: WellnessBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, viewport) {
              final availableHeight = viewport.maxHeight - outerPadding * 2;
              return SingleChildScrollView(
                padding: EdgeInsets.all(outerPadding),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: WellnessSpacing.onboardingMaxWidth,
                    ),
                    child: SizedBox(
                      height: availableHeight.clamp(620.0, 820.0).toDouble(),
                      child: Obx(() {
                        final slide = OnboardingController
                            .slides[controller.pageIndex.value];
                        return WellnessBlurContainer(
                          radius: 36,
                          padding: EdgeInsets.all(
                            compactViewport
                                ? WellnessSpacing.lg
                                : WellnessSpacing.xl,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        const SizedBox(
                                          height: WellnessSpacing.xs,
                                        ),
                                        Text(
                                          'A thoughtful cycle space in four short steps',
                                          style: WellnessTextStyles.caption(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.goLogin,
                                    child: const Text(
                                      'I already have an account',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: WellnessSpacing.md),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: LinearProgressIndicator(
                                  value:
                                      (controller.pageIndex.value + 1) /
                                      OnboardingController.slides.length,
                                  minHeight: 8,
                                  backgroundColor: WellnessColors.border,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        WellnessColors.primaryDeep,
                                      ),
                                ),
                              ),
                              const SizedBox(height: WellnessSpacing.md),
                              Text(
                                'Step ${controller.pageIndex.value + 1} of ${OnboardingController.slides.length}',
                                style: WellnessTextStyles.caption(
                                  context,
                                ).copyWith(fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final wide =
                                        WellnessResponsive.useWideOnboarding(
                                          constraints.maxWidth,
                                        );
                                    final compactHeight =
                                        constraints.maxHeight < 470;
                                    final illustration = _IllustrationCard(
                                      icon: _iconFor(slide.$3),
                                    );
                                    final copy = _CopyBlock(
                                      title: slide.$1,
                                      subtitle: slide.$2,
                                      points: _pointsForSlide(
                                        controller.pageIndex.value,
                                      ),
                                      titleFontSize: wide
                                          ? (compactHeight ? 38 : 44)
                                          : 34,
                                      pointGap: compactHeight
                                          ? WellnessSpacing.xs
                                          : WellnessSpacing.sm,
                                    );

                                    if (wide) {
                                      return Row(
                                        children: [
                                          Expanded(child: illustration),
                                          const SizedBox(
                                            width: WellnessSpacing.xl,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical:
                                                        WellnessSpacing.sm,
                                                  ),
                                              child: copy,
                                            ),
                                          ),
                                        ],
                                      );
                                    }

                                    return SingleChildScrollView(
                                      padding: const EdgeInsets.only(
                                        top: WellnessSpacing.md,
                                        bottom: WellnessSpacing.sm,
                                      ),
                                      child: Column(
                                        children: [
                                          illustration,
                                          const SizedBox(
                                            height: WellnessSpacing.xl,
                                          ),
                                          copy,
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  OnboardingController.slides.length,
                                  (i) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 220),
                                    width: i == controller.pageIndex.value
                                        ? 30
                                        : 10,
                                    height: 10,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      color: i == controller.pageIndex.value
                                          ? WellnessColors.primaryDeep
                                          : WellnessColors.border,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: WellnessSpacing.lg),
                              Row(
                                children: [
                                  if (controller.pageIndex.value > 0)
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: controller.previous,
                                        child: const Text('Back'),
                                      ),
                                    ),
                                  if (controller.pageIndex.value > 0)
                                    const SizedBox(width: WellnessSpacing.md),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: controller.goRegister,
                                      child: const Text('Create account now'),
                                    ),
                                  ),
                                  const SizedBox(width: WellnessSpacing.md),
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: controller.next,
                                      child: Text(
                                        controller.pageIndex.value ==
                                                OnboardingController
                                                        .slides
                                                        .length -
                                                    1
                                            ? 'Go to sign in'
                                            : 'Continue',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: WellnessSpacing.sm),
                              Text(
                                'Designed to help you feel informed, supported, and safe.',
                                textAlign: TextAlign.center,
                                style: WellnessTextStyles.caption(context)
                                    .copyWith(
                                      color: WellnessColors.textSecondaryFor(
                                        brightness,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String key) => switch (key) {
    'shield_outlined' => Icons.shield_outlined,
    'calendar_month_outlined' => Icons.calendar_month_outlined,
    'insights_outlined' => Icons.insights_outlined,
    _ => Icons.lock_person_outlined,
  };

  List<String> _pointsForSlide(int index) => switch (index) {
    0 => [
      'Private by design, not as an afterthought',
      'A calmer way to return to your data each day',
    ],
    1 => [
      'Quick logging for periods, moods, symptoms, and energy',
      'Built to be useful even on low-energy days',
    ],
    2 => [
      'Predictions become more meaningful as you keep logging',
      'Reports help surface recurring patterns, not just dates',
    ],
    _ => [
      'Discreet lock-screen notifications when you want them',
      'You can edit, export, or delete wellness data anytime',
    ],
  };
}

class _MobileOnboardingView extends StatelessWidget {
  const _MobileOnboardingView({
    required this.controller,
    required this.iconFor,
    required this.pointsForSlide,
  });

  final OnboardingController controller;
  final IconData Function(String key) iconFor;
  final List<String> Function(int index) pointsForSlide;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      body: WellnessBackground(
        child: SafeArea(
          child: Obx(() {
            final index = controller.pageIndex.value;
            final slide = OnboardingController.slides[index];
            final points = pointsForSlide(index);

            return LayoutBuilder(
              builder: (context, constraints) {
                final heroSize = (constraints.maxWidth * 0.7)
                    .clamp(220.0, 300.0)
                    .toDouble();
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: WellnessSpacing.xs),
                                Text(
                                  'Step ${index + 1} of ${OnboardingController.slides.length}',
                                  style: WellnessTextStyles.caption(context),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: controller.goLogin,
                            child: const Text('Sign in'),
                          ),
                        ],
                      ),
                      const SizedBox(height: WellnessSpacing.lg),
                      _MobileStepDots(currentIndex: index),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onHorizontalDragEnd: (details) {
                            final velocity = details.primaryVelocity ?? 0;
                            if (velocity < -260) {
                              controller.next();
                            } else if (velocity > 260) {
                              controller.previous();
                            }
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) {
                              final curved = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              );
                              return FadeTransition(
                                opacity: curved,
                                child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 0.98,
                                    end: 1,
                                  ).animate(curved),
                                  child: child,
                                ),
                              );
                            },
                            child: Column(
                              key: ValueKey(index),
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  child: _MobileIllustration(
                                    icon: iconFor(slide.$3),
                                    size: heroSize,
                                    index: index,
                                  ),
                                ),
                                const SizedBox(height: WellnessSpacing.xxl),
                                Text(
                                  _mobileTitleFor(index, slide.$1),
                                  textAlign: TextAlign.center,
                                  style: WellnessTextStyles.display(
                                    color: WellnessColors.textPrimaryFor(
                                      brightness,
                                    ),
                                  ).copyWith(fontSize: 28, height: 1.12),
                                ),
                                const SizedBox(height: WellnessSpacing.md),
                                Text(
                                  slide.$2,
                                  textAlign: TextAlign.center,
                                  style: WellnessTextStyles.body.copyWith(
                                    color: WellnessColors.textSecondaryFor(
                                      brightness,
                                    ),
                                    fontSize: 15,
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: WellnessSpacing.xl),
                                Align(
                                  child: _MobileBenefitPill(text: points.first),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: controller.next,
                        child: Text(
                          index == OnboardingController.slides.length - 1
                              ? 'Start using the app'
                              : 'Continue',
                        ),
                      ),
                      const SizedBox(height: WellnessSpacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (index > 0)
                            TextButton(
                              onPressed: controller.previous,
                              child: const Text('Back'),
                            ),
                          TextButton(
                            onPressed: controller.goRegister,
                            child: const Text('Create account'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  String _mobileTitleFor(int index, String fallback) => switch (index) {
    1 => 'Log your day in under a minute',
    2 => 'Understand your cycle rhythm',
    3 => 'Your privacy stays in your control',
    _ => fallback,
  };
}

class _MobileStepDots extends StatelessWidget {
  const _MobileStepDots({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        OnboardingController.slides.length,
        (i) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 6,
            margin: EdgeInsets.only(
              right: i == OnboardingController.slides.length - 1 ? 0 : 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: i <= currentIndex
                  ? WellnessColors.primaryDeep
                  : WellnessColors.border,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileIllustration extends StatelessWidget {
  const _MobileIllustration({
    required this.icon,
    required this.size,
    required this.index,
  });

  final IconData icon;
  final double size;
  final int index;

  @override
  Widget build(BuildContext context) {
    final glowColors = [
      const Color(0xFFF7C9DD),
      const Color(0xFFE8D4FA),
      const Color(0xFFF2C4E2),
      const Color(0xFFDCC8F4),
    ];
    final glow = glowColors[index % glowColors.length];

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFFFFF2F8), glow, const Color(0xFFF0E5FA)],
            stops: const [0.0, 0.54, 1.0],
          ),
          border: Border.all(
            color: WellnessColors.border.withValues(alpha: 0.82),
          ),
          boxShadow: [
            BoxShadow(
              color: WellnessColors.primaryDeep.withValues(alpha: 0.18),
              blurRadius: 42,
              offset: const Offset(0, 22),
            ),
            BoxShadow(
              color: glow.withValues(alpha: 0.5),
              blurRadius: 34,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: size * 0.12,
              right: size * 0.13,
              child: _MiniBadge(icon: _supportingIcon(index, true)),
            ),
            Positioned(
              left: size * 0.13,
              bottom: size * 0.14,
              child: _MiniBadge(icon: _supportingIcon(index, false)),
            ),
            Positioned(
              top: size * 0.18,
              left: size * 0.18,
              right: size * 0.18,
              child: _SignalLine(
                color: WellnessColors.textMuted,
                opacity: 0.22,
              ),
            ),
            Positioned(
              left: size * 0.24,
              right: size * 0.24,
              bottom: size * 0.18,
              child: _SignalLine(color: WellnessColors.accent, opacity: 0.18),
            ),
            Container(
              width: size * 0.46,
              height: size * 0.46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: WellnessColors.primaryDeep,
                boxShadow: [
                  BoxShadow(
                    color: WellnessColors.primaryDeep.withValues(alpha: 0.24),
                    blurRadius: 26,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Icon(icon, size: size * 0.22, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  IconData _supportingIcon(int index, bool primary) {
    return switch ((index, primary)) {
      (0, true) => Icons.verified_user_rounded,
      (0, false) => Icons.lock_rounded,
      (1, true) => Icons.edit_note_rounded,
      (1, false) => Icons.favorite_rounded,
      (2, true) => Icons.calendar_month_rounded,
      (2, false) => Icons.auto_graph_rounded,
      (3, true) => Icons.notifications_off_rounded,
      _ => Icons.delete_outline_rounded,
    };
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: WellnessColors.border.withValues(alpha: 0.65),
        ),
      ),
      child: Icon(icon, size: 19, color: WellnessColors.primaryDeep),
    );
  }
}

class _SignalLine extends StatelessWidget {
  const _SignalLine({required this.color, required this.opacity});

  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: color.withValues(alpha: opacity),
        ),
      ),
    );
  }
}

class _MobileBenefitPill extends StatelessWidget {
  const _MobileBenefitPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 290),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: WellnessSpacing.md,
          vertical: WellnessSpacing.md,
        ),
        decoration: BoxDecoration(
          color: WellnessColors.primaryHot.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: WellnessColors.primaryHot.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: WellnessColors.primaryDeep,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: WellnessSpacing.sm),
            Flexible(
              child: Text(
                text,
                style: WellnessTextStyles.caption(context).copyWith(
                  color: WellnessColors.textPrimaryFor(brightness),
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IllustrationCard extends StatelessWidget {
  const _IllustrationCard({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0x33F5B7C5), Color(0x44D8B4FE), Color(0x33FDBA74)],
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: WellnessColors.glowLavender.withValues(alpha: 0.18),
              ),
            ),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [WellnessColors.primaryHot, WellnessColors.secondary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: WellnessColors.primaryHot.withValues(alpha: 0.28),
                    blurRadius: 30,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: Icon(icon, size: 58, color: WellnessColors.textOnPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyBlock extends StatelessWidget {
  const _CopyBlock({
    required this.title,
    required this.subtitle,
    required this.points,
    required this.titleFontSize,
    required this.pointGap,
  });

  final String title;
  final String subtitle;
  final List<String> points;
  final double titleFontSize;
  final double pointGap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A more personal wellness ritual',
          style: WellnessTextStyles.caption(
            context,
          ).copyWith(letterSpacing: 0.4),
        ),
        const SizedBox(height: WellnessSpacing.md),
        Text(
          title,
          style: WellnessTextStyles.display(
            color: WellnessColors.textPrimaryFor(brightness),
          ).copyWith(fontSize: titleFontSize),
        ),
        const SizedBox(height: WellnessSpacing.md),
        Text(
          subtitle,
          style: WellnessTextStyles.body.copyWith(
            color: WellnessColors.textSecondaryFor(brightness),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: WellnessSpacing.lg),
        for (final point in points) ...[
          _PointRow(text: point),
          SizedBox(height: pointGap),
        ],
      ],
    );
  }
}

class _PointRow extends StatelessWidget {
  const _PointRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: WellnessColors.primaryHot,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 16,
            color: WellnessColors.primaryDeep,
          ),
        ),
        const SizedBox(width: WellnessSpacing.sm),
        Expanded(child: Text(text, style: WellnessTextStyles.bodyFor(context))),
      ],
    );
  }
}
