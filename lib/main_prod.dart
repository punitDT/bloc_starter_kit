import 'package:bloc_starter_kit/app.dart';
import 'package:bloc_starter_kit/bootstrap.dart';
import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:bloc_starter_kit/core/env/env.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
  await configureDependencies(EnvFlavor.prod);
  runApp(const App());
}
