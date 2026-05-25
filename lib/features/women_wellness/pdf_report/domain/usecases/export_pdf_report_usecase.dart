import 'dart:typed_data';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_pdf_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';

/// Exports the wellness report as PDF bytes.
class ExportPdfReportUseCase {
  const ExportPdfReportUseCase(
    this.profileRepository,
    this.periodTrackingRepository,
  );

  final WellnessProfileRepository profileRepository;
  final PeriodTrackingRepository periodTrackingRepository;

  Future<Uint8List> call(WellnessReport report) async {
    final profile = await profileRepository.getProfile();
    if (profile == null) {
      throw StateError('Wellness profile is required for PDF export.');
    }
    return WellnessPdfHelper.buildReport(
      profile: profile,
      report: report,
      periods: await periodTrackingRepository.getPeriodHistory(),
    );
  }
}
