import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_page_container.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/presentation/controllers/pdf_preview_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';

/// PDF report preview and export screen.
class PdfReportPreviewPage extends GetView<PdfPreviewController> {
  const PdfReportPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      final bytes = controller.pdfBytes.value;
      if (bytes == null) {
        return const SizedBox.shrink();
      }
      return SingleChildScrollView(
        child: WellnessPageContainer(
          maxWidth: 1400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const WellnessInsightCard(
                title: 'Shareable wellness snapshot',
                message:
                    'Preview a more polished summary of your cycle trends and wellness history before printing or sharing.',
                icon: Icons.picture_as_pdf_outlined,
              ),
              const SizedBox(height: WellnessSpacing.lg),
              WellnessCard(
                child: Text(
                  WellnessConstants.disclaimer,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: WellnessSpacing.lg),
              SizedBox(
                height: 840,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: PdfPreview(
                    build: (_) async => bytes,
                    canChangePageFormat: false,
                    canChangeOrientation: false,
                    allowPrinting: true,
                    allowSharing: true,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
