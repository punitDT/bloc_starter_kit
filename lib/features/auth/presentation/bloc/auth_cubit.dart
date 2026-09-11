import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.failure,
  });

  final AuthStatus status;
  final User? user;
  final Failure? failure;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  bool get isLoading => status == AuthStatus.loading;

  @override
  List<Object?> get props => [status, user, failure];
}

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void loginSuccess(User user) {
    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        clearFailure: true,
      ),
    );
  }

  void registerSuccess(User user) {
    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        clearFailure: true,
      ),
    );
  }

  void loginFailed(Failure failure) {
    emit(state.copyWith(status: AuthStatus.failure, failure: failure));
  }

  void logout() {
    emit(
      const AuthState(status: AuthStatus.unauthenticated),
    );
  }
}
