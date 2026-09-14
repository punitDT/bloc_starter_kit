import 'dart:async';

import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:bloc_starter_kit/core/utils/helpers/validators.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/primary_button.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/secondary_button.dart';
import 'package:bloc_starter_kit/core/widgets/inputs/app_text_field.dart';
import 'package:bloc_starter_kit/core/widgets/layout/max_width_container.dart';
import 'package:bloc_starter_kit/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Login screen.
class LoginPage extends StatefulWidget {
  /// Creates the login page.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    unawaited(
      context.read<AuthCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthAuthenticated():
                if (context.mounted) context.go(RoutePaths.home);
              case AuthFailure(:final failure):
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.failureMessage(failure)),
                    ),
                  );
                }
              case AuthInitial():
              case AuthLoading():
              case AuthUnauthenticated():
                break;
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLargeScreen =
                  constraints.maxWidth > AppBreakpoints.largeScreenMinWidth;
              final form = Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      context.l10n.login,
                      style: context.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppTextField(
                      controller: _emailController,
                      label: context.l10n.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: (value) => Validators.validateEmail(
                        value,
                        requiredMessage: context.l10n.emailRequired,
                        invalidMessage: context.l10n.emailInvalid,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _passwordController,
                      label: context.l10n.password,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      validator: (value) => Validators.validatePassword(
                        value,
                        requiredMessage: context.l10n.passwordRequired,
                        weakMessage: context.l10n.passwordWeak,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            context.goNamed(RouteNames.forgotPassword),
                        child: Text(context.l10n.forgotPassword),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (prev, next) =>
                          prev.isLoading != next.isLoading,
                      builder: (context, state) => PrimaryButton(
                        onPressed: state.isLoading ? null : _submit,
                        isLoading: state.isLoading,
                        label: context.l10n.login,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SecondaryButton(
                      onPressed: () => context.goNamed(RouteNames.register),
                      label: context.l10n.register,
                    ),
                  ],
                ),
              );

              if (isLargeScreen) {
                return SingleChildScrollView(
                  child: MaxWidthContainer(child: form),
                );
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: form,
              );
            },
          ),
        ),
      ),
    );
  }
}
