/// Cycle prediction result. All values are estimates.
class CyclePrediction {
  const CyclePrediction({
    required this.nextPeriodDate,
    required this.ovulationDate,
    required this.fertileWindowStart,
    required this.fertileWindowEnd,
    required this.pmsStartDate,
    required this.pmsEndDate,
    required this.currentCycleDay,
    required this.daysUntilNextPeriod,
    required this.isLate,
    this.warningMessage,
  });

  final DateTime nextPeriodDate;
  final DateTime ovulationDate;
  final DateTime fertileWindowStart;
  final DateTime fertileWindowEnd;
  final DateTime pmsStartDate;
  final DateTime pmsEndDate;
  final int currentCycleDay;
  final int daysUntilNextPeriod;
  final bool isLate;
  final String? warningMessage;
}
