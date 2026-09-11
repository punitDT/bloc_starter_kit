import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_config.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> initialize() async {
    emit(state.copyWith(status: SplashStatus.loading, message: 'Loading services…'));

    await Future<void>.delayed(AppConfig.splashDelay);

    emit(
      state.copyWith(
        status: SplashStatus.ready,
        message: 'Welcome back',
      ),
    );
  }
}
