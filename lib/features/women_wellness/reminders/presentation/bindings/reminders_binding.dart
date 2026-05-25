import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/repositories/reminders_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/usecases/get_reminders_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/domain/usecases/update_reminder_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/presentation/controllers/reminder_settings_controller.dart';

class RemindersBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(() => GetRemindersUseCase(Get.find<RemindersRepository>()));
    ensureLazyPut(
      () => UpdateReminderUseCase(Get.find<RemindersRepository>()),
    );
    ensureLazyPut(
      () => ReminderSettingsController(
        Get.find<GetRemindersUseCase>(),
        Get.find<UpdateReminderUseCase>(),
      ),
    );
  }
}
