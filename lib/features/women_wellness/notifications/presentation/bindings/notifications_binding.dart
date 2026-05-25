import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/notifications/domain/repositories/notifications_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/presentation/controllers/notifications_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<NotificationsController>()) {
      Get.lazyPut(
        () => NotificationsController(
          Get.find<NotificationsRepository>(),
          Get.find<PrivacyRepository>(),
        ),
        fenix: true,
      );
    }
  }
}
