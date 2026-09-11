import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../settings/cubit/theme_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final title = state.items[state.selectedIndex];

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                IconButton(
                  onPressed: () => context.read<ThemeCubit>().toggle(),
                  icon: const Icon(Icons.dark_mode_outlined),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _OverviewCard(title: title),
                  const SizedBox(height: 16),
                  _StatsGrid(),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (index) => context.read<HomeCubit>().changeTab(index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Overview'),
                NavigationDestination(icon: Icon(Icons.analytics_outlined), label: 'Activity'),
                NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Production',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'A scalable starter kit built with BLoC, secure storage, and a clean router architecture.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem(label: 'Performance', value: '96%', accent: Colors.green),
      _StatItem(label: 'Security', value: 'A+', accent: Colors.blue),
      _StatItem(label: 'Uptime', value: '99.9%', accent: Colors.orange),
      _StatItem(label: 'Latency', value: '120ms', accent: Colors.purple),
    ];

    return GridView.builder(
      itemCount: stats.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final item = stats[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatItem {
  const _StatItem({required this.label, required this.value, required this.accent});

  final String label;
  final String value;
  final Color accent;
}
