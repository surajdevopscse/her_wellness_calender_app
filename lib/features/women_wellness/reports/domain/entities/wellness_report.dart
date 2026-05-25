/// Analytics report for cycles, symptoms, mood, pain, flow, and summaries.
class WellnessReport {
  const WellnessReport({
    required this.averageCycleLength,
    required this.averagePeriodLength,
    required this.cycleRegularity,
    required this.cycleLengthTrend,
    required this.symptomFrequency,
    required this.moodDistribution,
    required this.painTrend,
    required this.flowTrend,
    required this.commonSymptoms,
    required this.pmsPattern,
    required this.hasLatePeriodAlert,
    required this.monthlySummary,
    required this.yearlySummary,
    required this.notes,
  });

  final double averageCycleLength;
  final double averagePeriodLength;
  final String cycleRegularity;
  final List<int> cycleLengthTrend;
  final Map<String, int> symptomFrequency;
  final Map<String, int> moodDistribution;
  final Map<String, int> painTrend;
  final Map<String, int> flowTrend;
  final List<String> commonSymptoms;
  final String pmsPattern;
  final bool hasLatePeriodAlert;
  final String monthlySummary;
  final String yearlySummary;
  final String notes;
}
