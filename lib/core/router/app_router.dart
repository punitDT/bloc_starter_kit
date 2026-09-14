import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:bloc_starter_kit/core/router/go_router_refresh.dart';
import 'package:bloc_starter_kit/core/router/routes.dart';
import 'package:bloc_starter_kit/features/auth/presentation/bloc/auth_cubit.dart';
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
import 'package:talker_flutter/talker_flutter.dart';

/// Declarative router (go_router).
///
/// No `Navigator.push` calls are allowed elsewhere. Guards live in
/// `redirect`, tab state in `StatefulShellRoute.indexedStack`.
@lazySingleton
final class AppRouter {
  /// Creates the router with injected auth state for testability.
  AppRouter(this._authCubit);

  final AuthCubit _authCubit;

  late final GoRouter _router = GoRouter(
    initialLocation: RoutePaths.splash,
    observers: [TalkerRouteObserver(getIt<Talker>())],
    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    redirect: (context, state) {
      final authState = _authCubit.state;
      final isAuthenticated = authState is AuthAuthenticated;
      final location = state.uri.path;

      if (!isAuthenticated &&
          RoutePaths.isProtected(location) &&
          !RoutePaths.isAuth(location)) {
        return AuthRoutes.login;
      }
      if (isAuthenticated && RoutePaths.isAuth(location)) {
        return RoutePaths.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.notifications,
                name: RouteNames.notifications,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: NotificationsPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                name: RouteNames.profile,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfilePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.settings,
                name: RouteNames.settings,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsPage(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AuthRoutes.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AuthRoutes.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AuthRoutes.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: ProfileRoutes.editProfile,
        name: RouteNames.editProfile,
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: ErrorRoutes.notFound,
        name: RouteNames.notFound,
        builder: (context, state) => const NotFoundPage(),
      ),
      GoRoute(
        path: ErrorRoutes.noInternet,
        name: RouteNames.noInternet,
        builder: (context, state) => const NoInternetPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  /// Exposes the configured router.
  GoRouter config() => _router;
}
