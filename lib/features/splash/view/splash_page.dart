import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..initialize(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.ready) {
            context.go('/home');
          }
        },
        builder: (context, state) {
          final isLoading = state.status == SplashStatus.loading;

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    size: 72,
                    color: Color(0xFF4F46E5),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Bloc Starter Kit',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 28),
                  if (isLoading)
                    const SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
