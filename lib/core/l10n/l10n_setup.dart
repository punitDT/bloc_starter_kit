import 'package:bloc_starter_kit/core/l10n/l10n.dart';
import 'package:bloc_starter_kit/core/network/network_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Localization setup with English and Arabic (RTL demo) support.
abstract final class L10nSetup {
  static const Locale en = Locale('en');
  static const Locale ar = Locale('ar');

  static const List<Locale> supportedLocales = [en, ar];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Locale resolution({
    required Locale? locale,
    required Iterable<Locale> supportedLocales,
  }) {
    if (locale == null) return en;
    for (final supported in supportedLocales) {
      if (supported.languageCode == locale.languageCode) return supported;
    }
    return en;
  }
}

extension BuildContextL10nX on BuildContext {
  AppLocalizations get l10n {
    final localizations =
        AppLocalizations.of(this);
    return localizations;
  }

  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDark => theme.brightness == Brightness.dark;
}

extension AppLocalizationsFailureX on AppLocalizations {
  /// Localized user-facing message for a domain [Failure].
  String failureMessage(Failure failure) => switch (failure) {
        NetworkFailure() => errorNetwork,
        TimeoutFailure() => errorTimeout,
        UnauthorizedFailure() => errorUnauthorized,
        ValidationFailure() => errorValidation,
        NotFoundFailure() => pageNotFoundMessage,
        CacheFailure() => errorGeneral,
        ServerFailure() => errorServer,
      };
}
