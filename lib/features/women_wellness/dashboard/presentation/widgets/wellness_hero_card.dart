import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/app_gradients.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/cycle_progress_ring.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_blur_container.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_phase_timeline.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/usecases/get_wellness_dashboard_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/wellness_metric_pill.dart';

/// Dashboard hero with emotional greeting, cycle ring, and phase timeline.
class WellnessHeroCard extends StatelessWidget {
  const WellnessHeroCard({super.key, required this.data, required this.tip});

  final WellnessDashboardData data;
  final String tip;

  @override
  Widget build(BuildContext context) {
    final next = data.prediction.daysUntilNextPeriod;
    final phaseName = _phaseName(data.prediction.currentCycleDay);

    return FadeInContainer(
      child: WellnessBlurContainer(
        radius: 34,
        gradient: Theme.of(context).brightness == Brightness.dark
            ? null
            : AppGradients.heroSoft,
        borderColor: Theme.of(context).brightness == Brightness.dark
            ? null
            : Colors.white.withValues(alpha: 0.74),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth > 760;
                final compact = constraints.maxWidth < 420;
                final copy = _HeroCopy(
                  greeting: _greeting(),
                  phaseName: phaseName,
                  next: next,
                  tip: tip,
                  compact: compact,
                  ovulationDate: WellnessDateHelper.shortDate.format(
                    data.prediction.ovulationDate,
                  ),
                );
                final ring = CycleProgressRing(
                  day: data.prediction.currentCycleDay,
                  totalDays: data.profile.averageCycleLength,
                  size: compact ? 138 : 166,
                );

                if (wide) {
                  return Row(
                    children: [
                      Expanded(flex: 6, child: copy),
                      const SizedBox(width: WellnessSpacing.xl),
                      ring,
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    copy,
                    SizedBox(
                      height: compact ? WellnessSpacing.lg : WellnessSpacing.xl,
                    ),
                    Align(alignment: Alignment.center, child: ring),
                  ],
                );
              },
            ),
            const SizedBox(height: WellnessSpacing.xl),
            WellnessPhaseTimeline(
              currentDay: data.prediction.currentCycleDay,
              totalDays: data.profile.averageCycleLength,
              compact: MediaQuery.sizeOf(context).width < 360,
            ),
          ],
        ),
      ),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  String _phaseName(int cycleDay) {
    if (cycleDay <= 5) return 'Menstrual';
    if (cycleDay <= 13) return 'Follicular';
    if (cycleDay <= 16) return 'Ovulation';
    return 'Luteal';
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.greeting,
    required this.phaseName,
    required this.next,
    required this.tip,
    required this.compact,
    required this.ovulationDate,
  });

  final String greeting;
  final String phaseName;
  final int next;
  final String tip;
  final bool compact;
  final String ovulationDate;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: brightness == Brightness.dark
                  ? WellnessColors.darkPrimary
                  : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              greeting,
              style: WellnessTextStyles.caption(
                context,
              ).copyWith(
                color: brightness == Brightness.dark
                    ? WellnessColors.darkTextSecondary
                    : Colors.white.withValues(alpha: 0.88),
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: WellnessSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final fontSize = constraints.maxWidth < 360
                ? 24.0
                : constraints.maxWidth < 520
                ? 32.0
                : 44.0;
            return Text(
              'You are in your $phaseName phase',
              maxLines: compact ? 3 : null,
              style: WellnessTextStyles.display(
                color: brightness == Brightness.dark
                    ? WellnessColors.darkTextPrimary
                    : Colors.white,
              ).copyWith(fontSize: fontSize, height: compact ? 1.06 : 1.1),
            );
          },
        ),
        const SizedBox(height: WellnessSpacing.md),
        Text(
          next >= 0
              ? 'Next period in $next days'
              : 'Your next period may be arriving later than expected.',
          style: WellnessTextStyles.body.copyWith(
            color: brightness == Brightness.dark
                ? WellnessColors.darkTextSecondary
                : Colors.white.withValues(alpha: 0.88),
            fontSize: compact ? 15 : 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: compact ? WellnessSpacing.md : WellnessSpacing.lg),
        if (compact) ...[
          WellnessMetricPill(
            icon: Icons.spa_outlined,
            label: 'Insight',
            value: tip,
            expand: true,
          ),
          const SizedBox(height: WellnessSpacing.sm),
          WellnessMetricPill(
            icon: Icons.wb_sunny_outlined,
            label: 'Ovulation',
            value: ovulationDate,
            expand: true,
          ),
        ] else
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              WellnessMetricPill(
                icon: Icons.spa_outlined,
                label: 'Insight',
                value: tip,
              ),
              WellnessMetricPill(
                icon: Icons.wb_sunny_outlined,
                label: 'Ovulation',
                value: ovulationDate,
              ),
            ],
          ),
      ],
    );
  }
}
