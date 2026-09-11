import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.isDarkMode});

  final bool isDarkMode;

  ThemeState copyWith({bool? isDarkMode}) {
    return ThemeState(isDarkMode: isDarkMode ?? this.isDarkMode);
  }

  @override
  List<Object> get props => [isDarkMode];
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._prefs) : super(const ThemeState(isDarkMode: false));

  final SharedPreferences _prefs;
  static const String _themeStorageKey = 'is_dark_mode';

  Future<void> load() async {
    final savedValue = _prefs.getBool(_themeStorageKey);
    emit(ThemeState(isDarkMode: savedValue ?? false));
  }

  Future<void> toggle() async {
    final nextValue = !state.isDarkMode;
    await _prefs.setBool(_themeStorageKey, nextValue);
    emit(state.copyWith(isDarkMode: nextValue));
  }
}
