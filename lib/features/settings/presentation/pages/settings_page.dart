import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/primary_button.dart';
import 'package:bloc_starter_kit/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ValueNotifier<bool> _notificationsEnabled = ValueNotifier(true);

  @override
  void dispose() {
    _notificationsEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _SectionHeader(title: context.l10n.theme),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.themeMode != current.themeMode,
            builder: (context, state) {
              return RadioGroup<ThemeMode>(
                groupValue: state.themeMode,
                onChanged: (mode) {
                  if (mode != null) {
                    context.read<HomeCubit>().setThemeMode(mode);
                  }
                },
                child: Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.system,
                      title: Text(context.l10n.systemMode),
                      secondary: const Icon(Icons.brightness_auto),
                    ),
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.light,
                      title: Text(context.l10n.lightMode),
                      secondary: const Icon(Icons.light_mode_outlined),
                    ),
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.dark,
                      title: Text(context.l10n.darkMode),
                      secondary: const Icon(Icons.dark_mode_outlined),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          _SectionHeader(title: context.l10n.language),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) => previous.locale != current.locale,
            builder: (context, state) {
              return RadioGroup<Locale>(
                groupValue: state.locale ?? L10nSetup.en,
                onChanged: (locale) {
                  if (locale != null) {
                    context.read<HomeCubit>().setLocale(locale);
                  }
                },
                child: Column(
                  children: [
                    RadioListTile<Locale>(
                      value: L10nSetup.en,
                      title: Text(context.l10n.english),
                      secondary: const Icon(Icons.language),
                    ),
                    RadioListTile<Locale>(
                      value: L10nSetup.ar,
                      title: Text(context.l10n.arabic),
                      secondary: const Icon(Icons.language),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          _SectionHeader(title: context.l10n.notifications),
          ValueListenableBuilder<bool>(
            valueListenable: _notificationsEnabled,
            builder: (context, enabled, _) => ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text(context.l10n.notifications),
              trailing: Switch(
                value: enabled,
                onChanged: (value) => _notificationsEnabled.value = value,
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryButton(
              onPressed: () => context.go(AuthRoutes.login),
              label: context.l10n.login,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
      child: Text(
        title,
        style: context.textTheme.titleSmall?.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
