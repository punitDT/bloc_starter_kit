import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.homeTitle,
                    style: context.textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    context.l10n.splashTagline,
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const _FeatureCard(
                    icon: Icons.architecture,
                    title: 'Clean Architecture',
                    subtitle: 'Feature-first with strict layer boundaries',
                  ),
                  const _FeatureCard(
                    icon: Icons.bolt,
                    title: 'BLoC Pattern',
                    subtitle: 'Testable state management with Freezed',
                  ),
                  const _FeatureCard(
                    icon: Icons.security,
                    title: 'Production Ready',
                    subtitle: 'Secure, optimized, and observability-first',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
          color: context.colorScheme.primary,
        ),
        title: Text(title, style: context.textTheme.titleMedium),
        subtitle: Text(subtitle, style: context.textTheme.bodyMedium),
      ),
    );
  }
}
