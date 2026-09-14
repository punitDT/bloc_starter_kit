import 'dart:async';

import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/core/storage/preferences.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, Preferences? preferences})
      : _preferences = preferences;

  final Preferences? _preferences;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    unawaited(_navigate());
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final preferences = widget._preferences ?? getIt<Preferences>();
    context.go(
      preferences.onboardingDone ? RoutePaths.home : RoutePaths.onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bolt,
              size: 96,
              color: context.colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.l10n.homeTitle,
              style: context.textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              context.l10n.splashTagline,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
