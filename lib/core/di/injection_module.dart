import 'package:bloc_starter_kit/core/observers/app_bloc_observer.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class AppModule {
  @lazySingleton
  Talker get talker => Talker();

  @singleton
  AppBlocObserver appBlocObserver(Talker talker) => AppBlocObserver(talker);

  @lazySingleton
  Dio dio() => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
        ),
      );
}
