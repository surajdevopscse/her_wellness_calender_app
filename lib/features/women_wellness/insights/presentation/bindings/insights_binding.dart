import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/reports/presentation/bindings/reports_binding.dart';

class InsightsBinding extends Bindings {
  @override
  void dependencies() {
    ReportsBinding().dependencies();
  }
}
