import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Global BLoC observer that routes all BLoC activity to Talker.
class AppBlocObserver extends BlocObserver {
  AppBlocObserver(this._talker);

  final Talker _talker;

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _talker.debug('${bloc.runtimeType} state changed: '
        '${change.currentState} → ${change.nextState}');
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
  }
}
