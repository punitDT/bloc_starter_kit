import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_starter_kit/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_starter_kit/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bloc_starter_kit/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('LoginUseCase', () {
    late MockAuthRepository repository;
    late LoginUseCase useCase;

    setUp(() {
      repository = MockAuthRepository();
      useCase = LoginUseCase(repository);
    });

    test('delegates to repository', () async {
      const user = User(id: '1', email: 'a@b.c', name: 'A');
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right<Failure, User>(user));

      final result = await useCase(
        const LoginParams(email: 'a@b.c', password: 'pw'),
      );
      expect(result.isRight(), isTrue);
      verify(
        () => repository.login(email: 'a@b.c', password: 'pw'),
      ).called(1);
    });
  });

  group('AuthCubit', () {
    late MockAuthRepository repository;

    AuthCubit buildCubit() => AuthCubit(
          LoginUseCase(repository),
          LogoutUseCase(repository),
          repository,
        );

    setUp(() {
      repository = MockAuthRepository();
      when(() => repository.logout())
          .thenAnswer((_) async => const Right<Failure, Unit>(unit));
    });

    blocTest<AuthCubit, AuthState>(
      'emits loading then authenticated on login success',
      build: () {
        when(
          () => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => const Right<Failure, User>(
            User(id: '1', email: 'a@b.c', name: 'A'),
          ),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.login(email: 'a@b.c', password: 'pw'),
      expect: () => [
        const AuthLoading(),
        const AuthAuthenticated(
          User(id: '1', email: 'a@b.c', name: 'A'),
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits failure on repository Left',
      build: () {
        when(
          () => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Left<Failure, User>(NetworkFailure()));
        return buildCubit();
      },
      act: (cubit) => cubit.login(email: 'a@b.c', password: 'pw'),
      expect: () => [
        const AuthLoading(),
        const AuthFailure(
          NetworkFailure(),
        ),
      ],
    );
  });
}
