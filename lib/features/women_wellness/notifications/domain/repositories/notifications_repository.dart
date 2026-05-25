import 'package:her_wellness_calender/features/women_wellness/notifications/domain/entities/notification_template.dart';

abstract class NotificationsRepository {
  Future<List<NotificationTemplate>> getTemplates();
}
