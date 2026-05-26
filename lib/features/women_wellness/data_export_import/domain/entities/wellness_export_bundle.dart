/// Aggregated wellness payload for export/import.
class WellnessExportBundle {
  const WellnessExportBundle({
    required this.exportedAt,
    required this.version,
    required this.profile,
    required this.periods,
    required this.dailyLogs,
    required this.symptoms,
    required this.reports,
    required this.reminders,
    required this.privacy,
  });

  final DateTime exportedAt;
  final String version;
  final Map<String, dynamic>? profile;
  final List<Map<String, dynamic>> periods;
  final List<Map<String, dynamic>> dailyLogs;
  final List<Map<String, dynamic>> symptoms;
  final Map<String, dynamic>? reports;
  final List<Map<String, dynamic>> reminders;
  final Map<String, dynamic>? privacy;

  Map<String, dynamic> toJson() => {
        'exportedAt': exportedAt.toIso8601String(),
        'version': version,
        'profile': profile,
        'periods': periods,
        'dailyLogs': dailyLogs,
        'symptoms': symptoms,
        'reports': reports,
        'reminders': reminders,
        'privacy': privacy,
      };
}
