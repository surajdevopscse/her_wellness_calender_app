import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:her_wellness_calender/app/app.dart';
import 'package:her_wellness_calender/app/di/app_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0, 101, 69, 69),
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await AppDependencies.initialize();

  runApp(const App());
}
