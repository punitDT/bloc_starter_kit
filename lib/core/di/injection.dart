import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';
import '../network/api_client.dart';
import '../storage/secure_storage_service.dart';
import '../../features/settings/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerLazySingleton(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions.defaultOptions,
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    ),
  );

  getIt.registerLazySingleton(() => SecureStorageService(getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => ApiClient());

  getIt.registerFactory(() => ThemeCubit(getIt<SharedPreferences>()));
}

String get appName => AppConfig.appName;
