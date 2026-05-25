import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/usecases/get_reminders_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/usecases/update_reminder_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reminder settings state.
class ReminderSettingsController extends GetxController {
  ReminderSettingsController(
    this.getRemindersUseCase,
    this.updateReminderUseCase,
  );

  final GetRemindersUseCase getRemindersUseCase;
  final UpdateReminderUseCase updateReminderUseCase;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final reminders = <WellnessReminder>[].obs;

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      reminders.value = await getRemindersUseCase();
    } catch (_) {
      errorMessage.value = WellnessConstants.error;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggle(WellnessReminder reminder, bool value) async {
    final updated = reminder.copyWith(isEnabled: value);
    await updateReminderUseCase(updated);
    reminders.value = reminders
        .map((item) => item.id == updated.id ? updated : item)
        .toList();
  }
}
