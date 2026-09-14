import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom-tab shell driven by a [StatefulNavigationShell].
///
/// Uses `navigationShell.currentIndex`/`goBranch` so each tab keeps its
/// own navigation stack, per `StatefulShellRoute.indexedStack`.
class HomeShell extends StatelessWidget {
  /// Creates the shell around [navigationShell].
  const HomeShell({
    required this.navigationShell,
    super.key,
  });

  /// Shell managing the tab branches.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
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
}
