import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Clears the session via [AuthRepository].
@injectable
class LogoutUseCase {
  /// Creates the use case.
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  /// Executes logout.
  Future<Either<Failure, Unit>> call() => _repository.logout();
}
