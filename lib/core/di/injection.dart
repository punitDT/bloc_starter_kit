import 'package:bloc_starter_kit/core/di/injection.config.dart';
import 'package:bloc_starter_kit/core/env/env.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies([EnvFlavor flavor = EnvFlavor.dev]) async {
  // Allowed for widget/bloc tests that re-register fakes after init.
  // Production code must not re-register; router/cubits are lazy singletons.
  getIt.allowReassignment = true;
  await getIt.init(environment: flavor.name);
}
