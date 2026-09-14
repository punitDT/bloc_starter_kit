import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_starter_kit/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_starter_kit/features/auth/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Authentication UI state — sealed hierarchy.
///
/// Impossible states are unrepresentable: loading carries no user,
/// failure carries a [Failure], authenticated carries a [User].
sealed class AuthState extends Equatable {
  /// Creates auth state.
  const AuthState();

  /// Whether an auth request is in flight.
  bool get isLoading => this is AuthLoading;

  /// Whether a user session exists.
  bool get isAuthenticated => this is AuthAuthenticated;
}

/// Initial state before any auth check.
final class AuthInitial extends AuthState {
  /// Creates initial state.
  const AuthInitial();

  @override
  List<Object?> get props => [];
}

/// Auth request in flight.
final class AuthLoading extends AuthState {
  /// Creates loading state.
  const AuthLoading();

  @override
  List<Object?> get props => [];
}

/// Authenticated with a user session.
final class AuthAuthenticated extends AuthState {
  /// Creates authenticated state.
  const AuthAuthenticated(this.user);

  /// Authenticated user.
  final User user;

  @override
  List<Object?> get props => [user];
}

/// No session (logged out / never logged in).
final class AuthUnauthenticated extends AuthState {
  /// Creates unauthenticated state.
  const AuthUnauthenticated();

  @override
  List<Object?> get props => [];
}

/// Last auth attempt failed.
final class AuthFailure extends AuthState {
  /// Creates failure state.
  const AuthFailure(this.failure);

  /// Failure details for display mapping.
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// Manages authentication by orchestrating use cases.
///
/// Widgets must call [login], [register], or [logout] instead of
/// constructing [User] directly. Navigation is handled by router guards.
@injectable
class AuthCubit extends Cubit<AuthState> {
  /// Creates the cubit.
  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._repository,
  ) : super(const AuthInitial());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthRepository _repository;

  /// Attempts login with email and password.
  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Attempts registration, then authenticates on success.
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(const AuthLoading());
    final result = await _repository.register(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Restores session from secure storage.
  Future<void> checkAuthStatus() async {
    final result = await _repository.getUser();
    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Logs out and clears the session.
  Future<void> logout() async {
    await _logoutUseCase();
    emit(
      const AuthUnauthenticated(),
    );
  }
}
