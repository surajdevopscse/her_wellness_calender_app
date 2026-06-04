import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/entities/wellness_dashboard_snapshot.dart';

abstract class DashboardRepository {
  Future<WellnessDashboardSnapshot?> getDashboard();
}
