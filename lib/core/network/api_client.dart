import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/app_config.dart';

class ApiClient {
  ApiClient() : _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl)) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    );
  }

  final Dio _dio;

  Dio get dio => _dio;

  Future<Response<dynamic>> getTodos({int limit = AppConfig.defaultPageSize}) async {
    final response = await _dio.get<dynamic>(
      '/todos',
      queryParameters: {'_limit': limit},
    );

    return response;
  }
}
