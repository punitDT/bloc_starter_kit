import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '404',
                style: context.textTheme.displayLarge?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                context.l10n.pageNotFound,
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.l10n.pageNotFoundMessage,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                onPressed: () => context.go(RoutePaths.home),
                label: context.l10n.continueAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
