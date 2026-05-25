import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';

class NotificationsMockDatasource {
  const NotificationsMockDatasource(this.assetLoader);
  static const assetPath = 'assets/mock/notifications.json';
  final MockAssetLoader assetLoader;
  Future<Map<String, dynamic>> load() => assetLoader.loadMap(assetPath);
}
