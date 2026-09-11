import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex(context),
        onDestinationSelected: (index) =>
            _onDestinationSelected(context, index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: context.l10n.homeTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications_outlined),
            selectedIcon: const Icon(Icons.notifications),
            label: context.l10n.notifications,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: context.l10n.profile,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: context.l10n.settings,
          ),
        ],
      ),
    );
  }

  int _selectedIndex(BuildContext context) {
    final route = GoRouterState.of(context).uri.path;
    if (route.startsWith(RoutePaths.notifications)) return 1;
    if (route.startsWith(RoutePaths.profile)) return 2;
    if (route.startsWith(RoutePaths.settings)) return 3;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final router = GoRouter.of(context);
    switch (index) {
      case 0:
        router.go(RoutePaths.home);
      case 1:
        router.go(RoutePaths.notifications);
      case 2:
        router.go(RoutePaths.profile);
      case 3:
        router.go(RoutePaths.settings);
    }
  }
}
