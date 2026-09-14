import 'package:bloc_starter_kit/app.dart';
import 'package:bloc_starter_kit/bootstrap.dart';
import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:bloc_starter_kit/core/env/env.dart';
import 'package:bloc_starter_kit/core/observers/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
  await configureDependencies(EnvFlavor.prod);
  Bloc.observer = getIt<AppBlocObserver>();
  runApp(const App());
}
