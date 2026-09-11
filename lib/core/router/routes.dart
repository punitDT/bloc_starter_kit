abstract final class RoutePaths {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const auth = '/auth';
  static const error = '/error';
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
