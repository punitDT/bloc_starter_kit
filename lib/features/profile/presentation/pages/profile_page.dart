import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/primary_button.dart';
import 'package:bloc_starter_kit/features/profile/domain/entities/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Profile overview screen.
///
/// Shows demo profile data with localized labels.
class ProfilePage extends StatelessWidget {
  /// Creates the profile page.
  const ProfilePage({super.key});

  static const demoProfile = Profile(
    name: 'Demo User',
    email: 'demo@example.com',
    phone: '+1 234 567 890',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.md),
            CircleAvatar(
              radius: 48,
              backgroundColor: context.colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 48,
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              demoProfile.name,
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Text(
              demoProfile.email,
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone_outlined),
                    title: Text(context.l10n.profilePhone),
                    subtitle: Text(demoProfile.phone ?? ''),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: Text(context.l10n.email),
                    subtitle: Text(demoProfile.email),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              onPressed: () => context.goNamed(RouteNames.editProfile),
              label: context.l10n.editProfile,
            ),
          ],
        ),
      ),
    );
  }
}
