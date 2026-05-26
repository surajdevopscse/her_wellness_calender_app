import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/notifications/domain/entities/notification_template.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/domain/repositories/notifications_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';

class NotificationsController extends GetxController {
  NotificationsController(this.notificationsRepository, this.privacyRepository);

  final NotificationsRepository notificationsRepository;
  final PrivacyRepository privacyRepository;
  final templates = <NotificationTemplate>[].obs;
  final hideSensitive = true.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      templates.assignAll(await notificationsRepository.getTemplates());
      final privacy = await privacyRepository.getSettings();
      hideSensitive.value = privacy?.hideNotificationText ?? true;
    } catch (_) {
      errorMessage.value = 'Unable to load notification settings.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleSensitiveText(bool value) async {
    final current = await privacyRepository.getSettings();
    if (current == null) {
      hideSensitive.value = value;
      return;
    }

    hideSensitive.value = value;
    try {
      await privacyRepository.updateSettings(
        current.copyWith(hideNotificationText: value),
      );
    } catch (_) {
      hideSensitive.value = !value;
      errorMessage.value = 'Unable to update notification privacy.';
    }
  }

  ({String title, String body}) previewFor(NotificationTemplate template) {
    if (hideSensitive.value) {
      return (title: template.privateTitle, body: template.privateBody);
    }
    return (title: template.visibleTitle, body: template.visibleBody);
  }
}
