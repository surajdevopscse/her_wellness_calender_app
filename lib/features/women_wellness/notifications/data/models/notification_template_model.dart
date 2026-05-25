import 'package:her_wellness_calender/features/women_wellness/notifications/domain/entities/notification_template.dart';

class NotificationTemplateModel {
  const NotificationTemplateModel({
    required this.id,
    required this.type,
    required this.privateTitle,
    required this.privateBody,
    required this.visibleTitle,
    required this.visibleBody,
  });

  final String id;
  final String type;
  final String privateTitle;
  final String privateBody;
  final String visibleTitle;
  final String visibleBody;

  factory NotificationTemplateModel.fromJson(Map<String, dynamic> json) {
    return NotificationTemplateModel(
      id: json['id'] as String,
      type: json['type'] as String,
      privateTitle: json['privateTitle'] as String,
      privateBody: json['privateBody'] as String,
      visibleTitle: json['visibleTitle'] as String,
      visibleBody: json['visibleBody'] as String,
    );
  }

  NotificationTemplate toEntity() => NotificationTemplate(
        id: id,
        type: type,
        privateTitle: privateTitle,
        privateBody: privateBody,
        visibleTitle: visibleTitle,
        visibleBody: visibleBody,
      );
}
