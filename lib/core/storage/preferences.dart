import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
final class Preferences {
  Preferences(this._prefs);

  final SharedPreferences _prefs;

  static const _onboardingDoneKey = 'onboarding_done';
  static const _themeModeKey = 'theme_mode';
  static const _localeKey = 'locale';

  bool get onboardingDone => _prefs.getBool(_onboardingDoneKey) ?? false;
  Future<void> setOnboardingDone({required bool value}) =>
      _prefs.setBool(_onboardingDoneKey, value);

  String? get themeMode => _prefs.getString(_themeModeKey);
  Future<void> setThemeMode(String value) =>
      _prefs.setString(_themeModeKey, value);

  String? get locale => _prefs.getString(_localeKey);
  Future<void> setLocale(String value) => _prefs.setString(_localeKey, value);
}
