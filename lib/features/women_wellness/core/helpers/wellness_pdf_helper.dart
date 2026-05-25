import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';

/// Builds a PDF report from wellness tracking data.
class WellnessPdfHelper {
  WellnessPdfHelper._();

  static Future<Uint8List> buildReport({
    required WellnessProfile profile,
    required WellnessReport report,
    required List<PeriodEntry> periods,
  }) async {
    final document = pw.Document();
    document.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(WellnessConstants.pdfReportHeading),
          ),
          pw.Text(WellnessConstants.medicalDisclaimer),
          pw.SizedBox(height: 16),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.profileSummary)),
          pw.Text(
            '${WellnessConstants.ageGroup}: ${profile.ageGroup ?? WellnessConstants.notSelected}',
          ),
          pw.Text(
            '${WellnessConstants.averageCycleLength}: ${profile.averageCycleLength} ${WellnessConstants.days}',
          ),
          pw.Text(
            '${WellnessConstants.averagePeriodLength}: ${profile.averagePeriodLength} ${WellnessConstants.days}',
          ),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.cycleSummary)),
          pw.Text(
            '${WellnessConstants.averageCycleLength}: ${report.averageCycleLength.toStringAsFixed(1)}',
          ),
          pw.Text(
            '${WellnessConstants.averagePeriodLength}: ${report.averagePeriodLength.toStringAsFixed(1)}',
          ),
          pw.Text(
            '${WellnessConstants.cycleRegularity}: ${report.cycleRegularity}',
          ),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.periodHistory)),
          ...periods.map(
            (entry) => pw.Text(
              '${WellnessDateHelper.shortDate.format(entry.startDate)} - ${entry.endDate == null ? WellnessConstants.active : WellnessDateHelper.shortDate.format(entry.endDate!)} (${entry.periodLength} ${WellnessConstants.days})',
            ),
          ),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.flowTrend)),
          pw.Text(report.flowTrend.toString()),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.painTrend)),
          pw.Text(report.painTrend.toString()),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.moodTrend)),
          pw.Text(report.moodDistribution.toString()),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.commonSymptoms)),
          pw.Text(report.commonSymptoms.join(', ')),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.pmsPattern)),
          pw.Text(report.pmsPattern),
          pw.Header(level: 1, child: pw.Text(WellnessConstants.notes)),
          pw.Text(report.notes),
          pw.SizedBox(height: 20),
          pw.Text(WellnessConstants.pdfFooter),
        ],
      ),
    );
    return document.save();
  }
}
