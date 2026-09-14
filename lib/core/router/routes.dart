/// Canonical path constants (URI-addressable, deep-link ready).
abstract final class RoutePaths {
  /// Splash entry.
  static const splash = '/splash';

  /// Onboarding flow.
  static const onboarding = '/onboarding';

  /// Bottom-tab shell destinations.
  static const home = '/home';

  /// User profile tab.
  static const profile = '/profile';

  /// Settings tab.
  static const settings = '/settings';

  /// Notifications tab.
  static const notifications = '/notifications';

  /// Auth group prefix.
  static const auth = '/auth';

  /// Error group prefix.
  static const error = '/error';

  /// Routes requiring an authenticated session.
  static const List<String> protectedPrefixes = [
    home,
    profile,
    settings,
    notifications,
  ];

  /// Whether [location] needs authentication.
  static bool isProtected(String location) =>
      protectedPrefixes.any(location.startsWith);

  /// Whether [location] is part of the auth flow.
  static bool isAuth(String location) => location.startsWith(auth);
}

/// Typed route names (use with `goNamed`).
abstract final class RouteNames {
  /// Splash screen.
  static const splash = 'splash';

  /// Onboarding screen.
  static const onboarding = 'onboarding';

  /// Home tab.
  static const home = 'home';

  /// Profile tab.
  static const profile = 'profile';

  /// Settings tab.
  static const settings = 'settings';

  /// Notifications tab.
  static const notifications = 'notifications';

  /// Login screen.
  static const login = 'login';

  /// Registration screen.
  static const register = 'register';

  /// Forgot-password screen.
  static const forgotPassword = 'forgotPassword';

  /// Edit-profile screen.
  static const editProfile = 'editProfile';

  /// 404 screen.
  static const notFound = 'notFound';

  /// Offline screen.
  static const noInternet = 'noInternet';
}

abstract final class AuthRoutes {
  static const String login = '${RoutePaths.auth}/login';
  static const String register = '${RoutePaths.auth}/register';
  static const String forgotPassword = '${RoutePaths.auth}/forgotPassword';
}

abstract final class OnboardingRoutes {
  static const String onboarding = RoutePaths.onboarding;
}

abstract final class ErrorRoutes {
  static const String notFound = '${RoutePaths.error}/notFound';
  static const String noInternet = '${RoutePaths.error}/noInternet';
}

abstract final class ProfileRoutes {
  static const String profile = RoutePaths.profile;
  static const String editProfile = '${RoutePaths.profile}/edit';
}

abstract final class NotificationRoutes {
  static const String notifications = RoutePaths.notifications;
}
