import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

/// Authentication data contract.
///
/// All methods return `Either` and never throw across layer boundaries.
abstract interface class AuthRepository {
  /// Logs in with email and password.
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Registers a new user.
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  });

  /// Returns the cached session user.
  Future<Either<Failure, User>> getUser();

  /// Clears tokens and session.
  Future<Either<Failure, Unit>> logout();
}
