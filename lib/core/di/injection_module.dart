import 'package:bloc_starter_kit/core/observers/app_bloc_observer.dart';
import 'package:bloc_starter_kit/core/storage/secure_storage.dart';
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
  Dio dio(SecureStorage secureStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment(
          'API_URL',
          defaultValue: 'https://api.example.com',
        ),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 15),
        headers: const {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final isRetry = error.requestOptions.extra['_isRetry'] == true;
          if (!isRetry && error.response?.statusCode == 401) {
            error.requestOptions.extra['_isRetry'] = true;
            try {
              return handler.resolve(await dio.fetch(error.requestOptions));
            } on DioException catch (_) {
              return handler.next(error);
            }
          }
          handler.next(error);
        },
      ),
    );
    return dio;
  }
}
