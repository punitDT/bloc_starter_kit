import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:bloc_starter_kit/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_starter_kit/features/auth/presentation/pages/register_page.dart';
import 'package:bloc_starter_kit/features/error/presentation/pages/no_internet_page.dart';
import 'package:bloc_starter_kit/features/error/presentation/pages/not_found_page.dart';
import 'package:bloc_starter_kit/features/home/presentation/pages/home_page.dart';
import 'package:bloc_starter_kit/features/home/presentation/shell/home_shell.dart';
import 'package:bloc_starter_kit/features/notifications/presentation/pages/notifications_page.dart';
import 'package:bloc_starter_kit/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:bloc_starter_kit/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:bloc_starter_kit/features/profile/presentation/pages/profile_page.dart';
import 'package:bloc_starter_kit/features/settings/presentation/pages/settings_page.dart';
import 'package:bloc_starter_kit/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@singleton
final class AppRouter {
  AppRouter();

  late final GoRouter _router = GoRouter(
    initialLocation: RoutePaths.splash,
    observers: const [],
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: RoutePaths.profile,
            name: 'profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfilePage(),
            ),
          ),
          GoRoute(
            path: RoutePaths.settings,
            name: 'settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsPage(),
            ),
          ),
          GoRoute(
            path: RoutePaths.notifications,
            name: 'notifications',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: NotificationsPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AuthRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AuthRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AuthRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: ProfileRoutes.editProfile,
        name: 'editProfile',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: ErrorRoutes.notFound,
        name: 'notFound',
        builder: (context, state) => const NotFoundPage(),
      ),
      GoRoute(
        path: ErrorRoutes.noInternet,
        name: 'noInternet',
        builder: (context, state) => const NoInternetPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  GoRouter config() => _router;
}
