import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/reminders/domain/entities/reminder.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/usecases/get_reminders_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/usecases/update_reminder_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/core/errors/exceptions.dart';

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
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = WellnessConstants.remindersLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggle(WellnessReminder reminder, bool value) async {
    final updated = reminder.copyWith(isEnabled: value);
    reminders.value = reminders
        .map((item) => item.id == updated.id ? updated : item)
        .toList();
    errorMessage.value = '';
    try {
      await updateReminderUseCase(updated);
      Get.snackbar(
        WellnessConstants.remindersTitle,
        WellnessConstants.reminderUpdated,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      _rollback(reminder);
      errorMessage.value = error.message;
    } catch (_) {
      _rollback(reminder);
      errorMessage.value = WellnessConstants.remindersSaveError;
    }
  }

  void _rollback(WellnessReminder reminder) {
    reminders.value = reminders
        .map((item) => item.id == reminder.id ? reminder : item)
        .toList();
  }
}
