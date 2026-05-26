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
    return Scaffold(
      body: WellnessBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(WellnessSpacing.xl),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: WellnessSpacing.onboardingMaxWidth,
                ),
                child: Obx(() {
                  final slide =
                      OnboardingController.slides[controller.pageIndex.value];
                  return WellnessBlurContainer(
                    radius: 36,
                    padding: const EdgeInsets.all(WellnessSpacing.xl),
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
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: WellnessSpacing.xs),
                                  Text(
                                    'A thoughtful cycle space in four short steps',
                                    style: WellnessTextStyles.caption(context),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: controller.goLogin,
                              child: const Text('I already have an account'),
                            ),
                          ],
                        ),
                        const SizedBox(height: WellnessSpacing.md),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: (controller.pageIndex.value + 1) /
                                OnboardingController.slides.length,
                            minHeight: 8,
                            backgroundColor: WellnessColors.border,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              WellnessColors.primaryDeep,
                            ),
                          ),
                        ),
                        const SizedBox(height: WellnessSpacing.md),
                        Text(
                          'Step ${controller.pageIndex.value + 1} of ${OnboardingController.slides.length}',
                          style: WellnessTextStyles.caption(context).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final wide = WellnessResponsive.useWideOnboarding(
                                constraints.maxWidth,
                              );
                              final illustration = _IllustrationCard(
                                icon: _iconFor(slide.$3),
                              );
                              final copy = _CopyBlock(
                                title: slide.$1,
                                subtitle: slide.$2,
                                points: _pointsForSlide(controller.pageIndex.value),
                              );
                              if (wide) {
                                return Row(
                                  children: [
                                    Expanded(child: illustration),
                                    const SizedBox(width: WellnessSpacing.xl),
                                    Expanded(child: copy),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  illustration,
                                  const SizedBox(height: WellnessSpacing.xl),
                                  copy,
                                ],
                              );
                            },
                          ),
                        ),
                        Row(
                          children: List.generate(
                            OnboardingController.slides.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: i == controller.pageIndex.value ? 30 : 10,
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
                                          OnboardingController.slides.length - 1
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
                          style: WellnessTextStyles.caption(context).copyWith(
                            color: WellnessColors.textSecondaryFor(brightness),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
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
            colors: [
              Color(0x33F5B7C5),
              Color(0x44D8B4FE),
              Color(0x33FDBA74),
            ],
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
  });

  final String title;
  final String subtitle;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A more personal wellness ritual',
          style: WellnessTextStyles.caption(context).copyWith(
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: WellnessSpacing.md),
        Text(
          title,
          style: WellnessTextStyles.display(
            color: WellnessColors.textPrimaryFor(brightness),
          ).copyWith(fontSize: 46),
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
          const SizedBox(height: WellnessSpacing.sm),
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
        Expanded(
          child: Text(
            text,
            style: WellnessTextStyles.bodyFor(context),
          ),
        ),
      ],
    );
  }
}
