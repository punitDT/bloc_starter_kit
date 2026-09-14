import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_starter_kit/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_starter_kit/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bloc_starter_kit/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bloc_starter_kit/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeAuthRepository extends Mock implements AuthRepository {}

void main() {
  testWidgets('LoginPage renders and validates email', (tester) async {
    final repository = FakeAuthRepository();
    final cubit = AuthCubit(
      LoginUseCase(repository),
      LogoutUseCase(repository),
      repository,
    );
    addTearDown(cubit.close);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: L10nSetup.localizationsDelegates,
        supportedLocales: L10nSetup.supportedLocales,
        home: BlocProvider<AuthCubit>.value(
          value: cubit,
          child: const LoginPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Login'), findsWidgets);
    await tester.enterText(find.byType(TextFormField).first, 'bad');
    await tester.tap(find.text('Login').last);
    await tester.pump();
    expect(find.text('Enter a valid email'), findsOneWidget);
  });
}
