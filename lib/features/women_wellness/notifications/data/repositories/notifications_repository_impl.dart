import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/data/datasources/notifications_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/data/models/notification_template_model.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/domain/entities/notification_template.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final NotificationsMockDatasource mockDatasource;
  final NotificationsRemoteDatasource remoteDatasource;

  @override
  Future<List<NotificationTemplate>> getTemplates() async {
    final response = environment.isMockMode
        ? await mockDatasource.load()
        : await remoteDatasource.getTemplates();
    final list = (response['data'] as Map<String, dynamic>)['templates']
        as List<dynamic>;
    return list
        .map((e) => NotificationTemplateModel.fromJson(e as Map<String, dynamic>))
        .map((m) => m.toEntity())
        .toList();
  }
}
