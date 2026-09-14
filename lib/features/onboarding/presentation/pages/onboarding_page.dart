import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/core/storage/preferences.dart';
import 'package:bloc_starter_kit/core/theme/app_decorations.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:bloc_starter_kit/core/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, Preferences? preferences})
      : _preferences = preferences;

  final Preferences? _preferences;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _currentPage = 0;

  static const List<({IconData icon, String subtitleKey, String titleKey})>
      _pages = [
    (
      icon: Icons.waving_hand,
      titleKey: 'onboardingTitle1',
      subtitleKey: 'onboardingSubtitle1'
    ),
    (
      icon: Icons.architecture,
      titleKey: 'onboardingTitle2',
      subtitleKey: 'onboardingSubtitle2'
    ),
    (
      icon: Icons.rocket_launch,
      titleKey: 'onboardingTitle3',
      subtitleKey: 'onboardingSubtitle3'
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    final preferences = widget._preferences ?? getIt<Preferences>();
    await preferences.setOnboardingDone(value: true);
    if (mounted) context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: Text(context.l10n.skip),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _OnboardingSlide(
                    icon: page.icon,
                    title: _titleFor(context, page.titleKey),
                    subtitle: _subtitleFor(context, page.subtitleKey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: AppDurations.fast,
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? context.colorScheme.primary
                              : context.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  if (_currentPage < _pages.length - 1)
                    PrimaryButton(
                      onPressed: () => _controller.nextPage(
                        duration: AppDurations.normal,
                        curve: Curves.easeInOut,
                      ),
                      label: context.l10n.next,
                    )
                  else
                    PrimaryButton(
                      onPressed: _finishOnboarding,
                      label: context.l10n.getStarted,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _titleFor(BuildContext context, String key) {
    return switch (key) {
      'onboardingTitle1' => context.l10n.onboardingTitle1,
      'onboardingTitle2' => context.l10n.onboardingTitle2,
      _ => context.l10n.onboardingTitle3,
    };
  }

  String _subtitleFor(BuildContext context, String key) {
    return switch (key) {
      'onboardingSubtitle1' => context.l10n.onboardingSubtitle1,
      'onboardingSubtitle2' => context.l10n.onboardingSubtitle2,
      _ => context.l10n.onboardingSubtitle3,
    };
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 96,
              color: context.colorScheme.onPrimaryContainer,
            ),
          )
              .animate()
              .fadeIn(duration: AppDurations.slow)
              .scale(duration: AppDurations.slow),
          const SizedBox(height: AppSpacing.xl),
          Text(
            title,
            style: context.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: AppDurations.slow).slideY(),
          const SizedBox(height: AppSpacing.md),
          Text(
            subtitle,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: AppDurations.slow).slideY(),
        ],
      ),
    );
  }
}
