import 'package:equatable/equatable.dart';

enum SplashStatus { initial, loading, ready }

class SplashState extends Equatable {
  const SplashState({
    this.status = SplashStatus.initial,
    this.message = 'Initializing app…',
  });

  final SplashStatus status;
  final String message;

  SplashState copyWith({SplashStatus? status, String? message}) {
    return SplashState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
