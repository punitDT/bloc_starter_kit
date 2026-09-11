// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:bloc_starter_kit/core/di/feature_module.dart' as _i363;
import 'package:bloc_starter_kit/core/di/injection_module.dart' as _i144;
import 'package:bloc_starter_kit/core/di/storage_module.dart' as _i792;
import 'package:bloc_starter_kit/core/network/network_failure.dart' as _i740;
import 'package:bloc_starter_kit/core/network/network_info.dart' as _i117;
import 'package:bloc_starter_kit/core/observers/app_bloc_observer.dart'
    as _i177;
import 'package:bloc_starter_kit/core/router/app_router.dart' as _i20;
import 'package:bloc_starter_kit/core/storage/preferences.dart' as _i154;
import 'package:bloc_starter_kit/core/storage/secure_storage.dart' as _i663;
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart'
    as _i441;
import 'package:bloc_starter_kit/features/home/presentation/cubit/home_cubit.dart'
    as _i918;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    final featureModule = _$FeatureModule();
    gh.factory<_i740.DioExceptionMapper>(() => _i740.DioExceptionMapper());
    gh.singleton<_i20.AppRouter>(() => _i20.AppRouter());
    gh.lazySingleton<_i207.Talker>(() => appModule.talker);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => storageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => storageModule.secureStorage());
    gh.lazySingleton<_i161.InternetConnection>(
        () => networkModule.internetConnection());
    gh.factory<_i663.SecureStorage>(
        () => _i663.SecureStorage(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i177.AppBlocObserver>(
        () => appModule.appBlocObserver(gh<_i207.Talker>()));
    gh.factory<_i154.Preferences>(
        () => _i154.Preferences(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i117.NetworkInfo>(
        () => _i117.NetworkInfoImpl(gh<_i161.InternetConnection>()));
    gh.singleton<_i918.HomeCubit>(
        () => featureModule.homeCubit(gh<_i154.Preferences>()));
    gh.lazySingleton<_i441.AuthRepository>(
        () => featureModule.authRepository(gh<_i663.SecureStorage>()));
    return this;
  }
}

class _$AppModule extends _i144.AppModule {}

class _$StorageModule extends _i792.StorageModule {}

class _$NetworkModule extends _i117.NetworkModule {}

class _$FeatureModule extends _i363.FeatureModule {}
