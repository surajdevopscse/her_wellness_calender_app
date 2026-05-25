import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';

/// Repository contract for wellness reports.
abstract class ReportsRepository {
  Future<WellnessReport> getReports({DateTime? startDate, DateTime? endDate});
}
