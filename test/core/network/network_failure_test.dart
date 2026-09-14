import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DioExceptionMapper', () {
    final mapper = DioExceptionMapper();

    DioException error(
      DioExceptionType type, {
      int? statusCode,
    }) {
      return DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: type,
        response: statusCode == null
            ? null
            : Response(
                requestOptions: RequestOptions(path: '/x'),
                statusCode: statusCode,
              ),
      );
    }

    test('maps timeouts', () {
      expect(
        mapper.map(error(DioExceptionType.connectionTimeout)),
        isA<TimeoutFailure>(),
      );
      expect(
        mapper.map(error(DioExceptionType.transformTimeout)),
        isA<TimeoutFailure>(),
      );
    });

    test('maps 401/404/422 via status-code patterns', () {
      expect(
        mapper.map(error(DioExceptionType.badResponse, statusCode: 401)),
        isA<UnauthorizedFailure>(),
      );
      expect(
        mapper.map(error(DioExceptionType.badResponse, statusCode: 404)),
        isA<NotFoundFailure>(),
      );
      expect(
        mapper.map(error(DioExceptionType.badResponse, statusCode: 422)),
        isA<ValidationFailure>(),
      );
      final server = mapper.map(
        error(DioExceptionType.badResponse, statusCode: 500),
      );
      expect((server as ServerFailure).statusCode, 500);
    });

    test('failureMessage is exhaustive', () {
      expect(failureMessage(const NetworkFailure()), contains('internet'));
      expect(
        failureMessage(const ServerFailure(statusCode: 500)),
        contains('500'),
      );
    });
  });
}
