import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Maps [DioException] to the domain [Failure] hierarchy.
///
/// Uses exhaustive switch expressions so new [DioExceptionType] values
/// fail at compile time instead of silently falling through.
@injectable
final class DioExceptionMapper {
  /// Converts a Dio error into a user-mappable failure.
  Failure map(DioException error) {
    final statusCode = error.response?.statusCode;
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout =>
        const TimeoutFailure(),
      DioExceptionType.badResponse => switch (statusCode) {
        401 => const UnauthorizedFailure(),
        404 => const NotFoundFailure(),
        422 => const ValidationFailure(),
        final int code => ServerFailure(statusCode: code),
        null => const ServerFailure(statusCode: 500),
      },
      DioExceptionType.connectionError ||
      DioExceptionType.cancel ||
      DioExceptionType.badCertificate ||
      DioExceptionType.unknown =>
        const NetworkFailure(),
    };
  }
}

/// Base type for all domain failures.
///
/// Kept `sealed` so `switch` over failures is exhaustive.
sealed class Failure {
  const Failure();
}

/// No connectivity or request cancelled.
final class NetworkFailure extends Failure {
  const NetworkFailure();
}

/// Request timed out.
final class TimeoutFailure extends Failure {
  const TimeoutFailure();
}

/// Server returned an error status code.
final class ServerFailure extends Failure {
  const ServerFailure({required this.statusCode});

  /// HTTP status code from the response.
  final int statusCode;
}

/// Session expired or credentials invalid.
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

/// Request payload failed server-side validation.
final class ValidationFailure extends Failure {
  const ValidationFailure();
}

/// Requested resource was not found.
final class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

/// Local cache read/write failed.
final class CacheFailure extends Failure {
  const CacheFailure();
}

/// Maps a [Failure] to a localization key-friendly message.
///
/// Prefer `context.l10n.failureMessage(failure)` in widgets for localized
/// output. This fallback keeps non-widget layers testable without BuildContext.
/// Callers should resolve these via `context.l10n` where possible.
String failureMessage(Failure failure) => switch (failure) {
  NetworkFailure() => 'No internet connection',
  TimeoutFailure() => 'The request timed out. Please try again.',
  UnauthorizedFailure() => 'Your session has expired. Please login again.',
  ValidationFailure() => 'Please check your input',
  NotFoundFailure() => 'The page you are looking for does not exist',
  CacheFailure() => 'Something went wrong',
  ServerFailure(statusCode: final code) => 'Server error ($code)',
};
