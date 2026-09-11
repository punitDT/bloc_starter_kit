import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

final class LoginParams {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;
}

final class LoginUseCase implements UseCase<User, LoginParams> {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
