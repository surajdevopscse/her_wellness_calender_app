import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';

/// Loads wellness analytics reports.
class GetReportsUseCase {
  const GetReportsUseCase(this.repository);

  final ReportsRepository repository;

  Future<WellnessReport> call({DateTime? startDate, DateTime? endDate}) =>
      repository.getReports(startDate: startDate, endDate: endDate);
}
