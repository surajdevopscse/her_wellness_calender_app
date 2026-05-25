enum DataSourceMode { local, remote }

class AppEnvironment {
  final String name;
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final DataSourceMode dataSourceMode;
  final bool enableApiLogs;

  const AppEnvironment({
    required this.name,
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.dataSourceMode,
    required this.enableApiLogs,
  });

  bool get isMockMode => dataSourceMode == DataSourceMode.local;

  // bool get isMockMode => false;

  static const AppEnvironment mock = AppEnvironment(
    name: 'mock',
    baseUrl: 'https://mock.her-wellness.local',
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 20),
    dataSourceMode: DataSourceMode.local,
    enableApiLogs: true,
  );

  static const AppEnvironment live = AppEnvironment(
    name: 'live',
    baseUrl: 'https://localhost:62773',
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 20),
    dataSourceMode: DataSourceMode.remote,
    enableApiLogs: true,
  );
}
