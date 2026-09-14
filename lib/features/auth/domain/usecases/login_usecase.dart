import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Base contract for single-purpose use cases.
abstract interface class UseCase<T, Params> {
  /// Executes the use case.
  Future<Either<Failure, T>> call(Params params);
}

/// Credentials required to log in.
final class LoginParams {
  /// Creates login params.
  const LoginParams({required this.email, required this.password});

  /// Email address.
  final String email;

  /// Raw password (never logged).
  final String password;
}

/// Authenticates a user via [AuthRepository].
@injectable
final class LoginUseCase implements UseCase<User, LoginParams> {
  /// Creates the use case.
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
