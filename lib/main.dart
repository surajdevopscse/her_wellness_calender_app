import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:her_wellness_calender/app/app.dart';
import 'package:her_wellness_calender/app/di/app_dependencies.dart';
import 'package:her_wellness_calender/app/environment/app_environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintBaselinesEnabled = false;
  debugPaintSizeEnabled = false;
  debugPaintPointersEnabled = false;
  debugRepaintRainbowEnabled = false;

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0, 101, 69, 69),
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await AppDependencies.initialize(environment: AppEnvironment.live);

  runApp(const App());
}
