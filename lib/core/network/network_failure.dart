import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
final class DioExceptionMapper {
  Failure map(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => const TimeoutFailure(),
      DioExceptionType.sendTimeout => const TimeoutFailure(),
      DioExceptionType.receiveTimeout => const TimeoutFailure(),
      DioExceptionType.badResponse => ServerFailure(
          statusCode: error.response?.statusCode ?? 500,
        ),
      DioExceptionType.connectionError => const NetworkFailure(),
      _ => const NetworkFailure(),
    };
  }
}

abstract class Failure {
  const Failure();
}

final class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure();
}

final class ServerFailure extends Failure {
  const ServerFailure({required this.statusCode});
  final int statusCode;
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

final class ValidationFailure extends Failure {
  const ValidationFailure();
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

final class CacheFailure extends Failure {
  const CacheFailure();
}
