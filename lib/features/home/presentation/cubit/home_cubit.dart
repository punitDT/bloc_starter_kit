import 'dart:async';

import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/storage/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.themeMode = ThemeMode.system,
    this.locale,
  });

  final ThemeMode themeMode;
  final Locale? locale;

  HomeState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool clearLocale = false,
  }) {
    return HomeState(
      themeMode: themeMode ?? this.themeMode,
      locale: clearLocale ? null : locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit(this._preferences) : super(const HomeState());

  final Preferences _preferences;

  void setThemeMode(ThemeMode mode) {
    unawaited(_preferences.setThemeMode(mode.name));
    emit(state.copyWith(themeMode: mode));
  }

  void setLocale(Locale locale) {
    unawaited(_preferences.setLocale(locale.languageCode));
    emit(state.copyWith(locale: locale));
  }

  void loadPreferences() {
    final savedTheme = _preferences.themeMode;
    final savedLocale = _preferences.locale;
    final themeMode = switch (savedTheme) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    final locale = savedLocale == null
        ? null
        : L10nSetup.supportedLocales.firstWhere(
            (supported) => supported.languageCode == savedLocale,
            orElse: () => L10nSetup.en,
          );
    emit(state.copyWith(themeMode: themeMode, locale: locale));
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    final themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == json['themeMode'],
      orElse: () => ThemeMode.system,
    );
    final localeCode = json['locale'] as String?;
    final locale = localeCode == null
        ? null
        : L10nSetup.supportedLocales.firstWhere(
            (supported) => supported.languageCode == localeCode,
            orElse: () => L10nSetup.en,
          );
    return HomeState(themeMode: themeMode, locale: locale);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return {
      'themeMode': state.themeMode.name,
      'locale': state.locale?.languageCode,
    };
  }
}
