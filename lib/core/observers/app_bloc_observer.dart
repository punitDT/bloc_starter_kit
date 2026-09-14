import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Global BLoC observer that routes all BLoC activity to Talker.
class AppBlocObserver extends BlocObserver {
  AppBlocObserver(this._talker);

  final Talker _talker;

  String _sanitize(Object? state) {
    final text = '$state';
    // Avoid logging PII (emails, tokens) at verbose level.
    if (text.contains('@') || text.contains('token')) return '[redacted PII]';
    return text.length > 500 ? '${text.substring(0, 500)}…' : text;
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _talker.debug('${bloc.runtimeType} state changed: '
        '${_sanitize(change.currentState)} → ${_sanitize(change.nextState)}');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _talker.debug('${bloc.runtimeType} transition: ${transition.event}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _talker.error('${bloc.runtimeType} error: $error', error, stackTrace);
    unawaited(Sentry.captureException(error, stackTrace: stackTrace));
  }
}
