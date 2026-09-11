import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:bloc_starter_kit/core/utils/extensions/string_ext.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/primary_button.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/secondary_button.dart';
import 'package:bloc_starter_kit/core/widgets/inputs/app_text_field.dart';
import 'package:bloc_starter_kit/features/auth/domain/entities/user.dart';
import 'package:bloc_starter_kit/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
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
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text;
    context.read<AuthCubit>().loginSuccess(
          User(
            id: 'demo-user',
            email: email,
            name: email.split('@').first,
          ),
        );
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.isEmail) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _passwordController,
                  label: context.l10n.password,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.goNamed('forgotPassword'),
                    child: Text(context.l10n.forgotPassword),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  onPressed: _submit,
                  label: context.l10n.login,
                ),
                const SizedBox(height: AppSpacing.md),
                SecondaryButton(
                  onPressed: () => context.goNamed('register'),
                  label: context.l10n.register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
