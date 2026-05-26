import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/entities/wellness_export_bundle.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/repositories/data_export_repository.dart';

class RestoreWellnessDataUseCase {
  const RestoreWellnessDataUseCase(this.repository);

  final DataExportRepository repository;

  Future<void> call(WellnessExportBundle bundle) =>
      repository.restoreFromBundle(bundle);
}
