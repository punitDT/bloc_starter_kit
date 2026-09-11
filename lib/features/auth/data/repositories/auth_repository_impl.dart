import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/core/storage/secure_storage.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._secureStorage);

  final SecureStorage _secureStorage;

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return Right(
      User(
        id: 'demo-user',
        email: email,
        name: 'Demo User',
      ),
    );
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return Right(
      User(id: 'demo-user', email: email, name: name),
    );
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    final hasToken = await _secureStorage.hasTokens;
    if (!hasToken) {
      return const Left(UnauthorizedFailure());
    }
    return const Right(
      User(
        id: 'demo-user',
        email: 'demo@example.com',
        name: 'Demo User',
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    await _secureStorage.clearTokens();
    return const Right(unit);
  }
}
