import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/presentation/controllers/setup_onboarding_controller.dart';

class SetupOnboardingPage extends GetView<SetupOnboardingController> {
  const SetupOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final background = WellnessColors.backgroundFor(brightness);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(WellnessSpacing.xl),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 420,
                    minHeight: constraints.maxHeight - WellnessSpacing.xxl,
                  ),
                  child: IntrinsicHeight(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _Header(
                            step: controller.pageIndex.value + 1,
                            totalSteps: SetupOnboardingController.totalSteps,
                            onBack: controller.back,
                          ),
                          const SizedBox(height: WellnessSpacing.xxl),
                          Expanded(
                            child: _StepBody(step: controller.pageIndex.value),
                          ),
                          const SizedBox(height: WellnessSpacing.xl),
                          FilledButton(
                            onPressed: controller.canContinue
                                ? controller.next
                                : null,
                            child: controller.isSaving.value
                                ? const SizedBox.square(
                                    dimension: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    controller.pageIndex.value ==
                                            SetupOnboardingController
                                                    .totalSteps -
                                                1
                                        ? 'Complete Setup'
                                        : 'Continue',
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.step,
    required this.totalSteps,
    required this.onBack,
  });

  final int step;
  final int totalSteps;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      children: [
        Row(
          children: [
            _CircleIconButton(
              icon: Icons.arrow_back_rounded,
              onPressed: onBack,
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Bloom',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: WellnessSpacing.compactIconBox),
          ],
        ),
        const SizedBox(height: WellnessSpacing.xl),
        Text(
          'STEP $step OF $totalSteps',
          textAlign: TextAlign.center,
          style: WellnessTextStyles.caption(context).copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: WellnessColors.textMuted,
          ),
        ),
        const SizedBox(height: WellnessSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalSteps,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: index < step ? 28 : 18,
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: index < step
                    ? WellnessColors.primaryDeep
                    : WellnessColors.borderFor(brightness),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StepBody extends GetView<SetupOnboardingController> {
  const _StepBody({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: switch (step) {
        0 => const _GoalStep(key: ValueKey('goal')),
        1 => const _LastPeriodStep(key: ValueKey('period')),
        2 => const _CycleLengthStep(key: ValueKey('cycle')),
        _ => const _PeriodLengthStep(key: ValueKey('length')),
      },
    );
  }
}

class _GoalStep extends GetView<SetupOnboardingController> {
  const _GoalStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _StepTitle(
          title: 'What is your primary goal?',
          subtitle: 'This helps us personalize your Bloom experience.',
        ),
        const SizedBox(height: WellnessSpacing.xl),
        _GoalTile(
          icon: Icons.water_drop_outlined,
          label: 'Track my period',
          value: SetupOnboardingController.goalTrackPeriod,
        ),
        const SizedBox(height: WellnessSpacing.md),
        _GoalTile(
          icon: Icons.favorite_border_rounded,
          label: 'Get pregnant',
          value: SetupOnboardingController.goalGetPregnant,
        ),
        const SizedBox(height: WellnessSpacing.md),
        _GoalTile(
          icon: Icons.pregnant_woman_rounded,
          label: 'Track pregnancy',
          value: SetupOnboardingController.goalTrackPregnancy,
        ),
        const SizedBox(height: WellnessSpacing.md),
        _GoalTile(
          icon: Icons.auto_awesome_outlined,
          label: 'Health insights',
          value: SetupOnboardingController.goalHealthInsights,
        ),
      ],
    );
  }
}

class _GoalTile extends GetView<SetupOnboardingController> {
  const _GoalTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      final selected = controller.selectedGoal.value == value;
      return InkWell(
        onTap: () => controller.selectGoal(value),
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(WellnessSpacing.md),
          decoration: BoxDecoration(
            color: WellnessColors.cardFor(brightness),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? WellnessColors.primaryDeep
                  : WellnessColors.borderFor(brightness),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: selected
                      ? WellnessColors.blush
                      : WellnessColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: selected
                      ? WellnessColors.periodDeep
                      : WellnessColors.primaryDeep,
                ),
              ),
              const SizedBox(width: WellnessSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected
                    ? WellnessColors.primaryDeep
                    : WellnessColors.borderFor(brightness),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _LastPeriodStep extends GetView<SetupOnboardingController> {
  const _LastPeriodStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _StepTitle(
          title: 'When did your last period start?',
          subtitle:
              'This helps us personalize your cycle predictions and health insights.',
        ),
        const SizedBox(height: WellnessSpacing.xl),
        const _CalendarCard(),
        const SizedBox(height: WellnessSpacing.lg),
        TextButton(
          onPressed: () {
            controller.selectDate(DateTime.now());
            controller.next();
          },
          child: const Text("I don't remember"),
        ),
      ],
    );
  }
}

class _CalendarCard extends GetView<SetupOnboardingController> {
  const _CalendarCard();

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const _weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      final month = controller.visibleMonth.value;
      final firstDay = DateTime(month.year, month.month);
      final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
      final leadingSpaces = firstDay.weekday - DateTime.monday;

      return Container(
        padding: const EdgeInsets.all(WellnessSpacing.lg),
        decoration: BoxDecoration(
          color: WellnessColors.cardFor(brightness),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: WellnessColors.borderFor(brightness)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _CircleIconButton(
                  icon: Icons.chevron_left_rounded,
                  onPressed: controller.previousMonth,
                ),
                Expanded(
                  child: Text(
                    _months[month.month - 1],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _CircleIconButton(
                  icon: Icons.chevron_right_rounded,
                  onPressed: controller.nextMonth,
                ),
              ],
            ),
            const SizedBox(height: WellnessSpacing.lg),
            Row(
              children: _weekdays
                  .map(
                    (day) => Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: WellnessTextStyles.caption(
                          context,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: WellnessSpacing.sm),
            Column(
              children: List.generate(
                6,
                (row) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: List.generate(7, (column) {
                      final index = row * 7 + column;
                      final day = index - leadingSpaces + 1;
                      if (day < 1 || day > daysInMonth) {
                        return const Expanded(child: SizedBox(height: 36));
                      }

                      final date = DateTime(month.year, month.month, day);
                      final selected = DateUtils.isSameDay(
                        controller.selectedDate.value,
                        date,
                      );

                      return Expanded(
                        child: _CalendarDay(
                          day: day,
                          selected: selected,
                          onTap: () => controller.selectDate(date),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.day,
    required this.selected,
    required this.onTap,
  });

  final int day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        height: 36,
        decoration: BoxDecoration(
          color: selected ? WellnessColors.primaryDeep : Colors.transparent,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '$day',
          style: WellnessTextStyles.caption(context).copyWith(
            color: selected
                ? WellnessColors.textOnPrimary
                : WellnessColors.textSecondaryFor(Theme.of(context).brightness),
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CycleLengthStep extends GetView<SetupOnboardingController> {
  const _CycleLengthStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _NumberStep(
        title: 'How long is your cycle?',
        subtitle:
            'This helps us personalize your tracking experience and improve prediction accuracy.',
        value: controller.cycleLength.value,
        unit: 'DAYS',
        helperText: 'Average is 28 days',
        onDecrement: controller.decrementCycleLength,
        onIncrement: controller.incrementCycleLength,
      ),
    );
  }
}

class _PeriodLengthStep extends GetView<SetupOnboardingController> {
  const _PeriodLengthStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _NumberStep(
        title: 'How many days does your period usually last?',
        subtitle: '',
        value: controller.periodLength.value,
        unit: 'DAYS',
        helperText: 'You can always adjust this later in your settings.',
        onDecrement: controller.decrementPeriodLength,
        onIncrement: controller.incrementPeriodLength,
      ),
    );
  }
}

class _NumberStep extends StatelessWidget {
  const _NumberStep({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.unit,
    required this.helperText,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String title;
  final String subtitle;
  final int value;
  final String unit;
  final String helperText;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepTitle(title: title, subtitle: subtitle),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RoundCounterButton(
              icon: Icons.remove_rounded,
              onPressed: onDecrement,
            ),
            const SizedBox(width: WellnessSpacing.xl),
            Column(
              children: [
                Text(
                  '$value',
                  style: WellnessTextStyles.heroNumber(
                    color: WellnessColors.primaryDeep,
                  ),
                ),
                Text(
                  unit,
                  style: WellnessTextStyles.caption(
                    context,
                  ).copyWith(fontSize: 10, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(width: WellnessSpacing.xl),
            _RoundCounterButton(
              icon: Icons.add_rounded,
              onPressed: onIncrement,
            ),
          ],
        ),
        const SizedBox(height: WellnessSpacing.xl),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: WellnessSpacing.md,
              vertical: WellnessSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: WellnessColors.secondary,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              helperText,
              textAlign: TextAlign.center,
              style: WellnessTextStyles.caption(
                context,
              ).copyWith(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _StepTitle extends StatelessWidget {
  const _StepTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.08,
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: WellnessSpacing.md),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: WellnessTextStyles.caption(context),
          ),
        ],
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: WellnessColors.cardFor(Theme.of(context).brightness),
        foregroundColor: WellnessColors.primaryDeep,
        minimumSize: const Size.square(WellnessSpacing.compactIconBox),
        shape: const CircleBorder(),
      ),
    );
  }
}

class _RoundCounterButton extends StatelessWidget {
  const _RoundCounterButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: WellnessColors.cardFor(Theme.of(context).brightness),
        foregroundColor: WellnessColors.primaryDeep,
        minimumSize: const Size.square(46),
        shape: const CircleBorder(),
      ),
    );
  }
}
