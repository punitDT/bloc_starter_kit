import 'package:bloc_starter_kit/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:equatable/equatable.dart';

/// Sealed notifications state — impossible states unrepresentable.
sealed class NotificationsState extends Equatable {
  /// Creates state.
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before load.
final class NotificationsInitial extends NotificationsState {
  /// Creates initial.
  const NotificationsInitial();
}

/// Loading in flight (no stale data).
final class NotificationsLoading extends NotificationsState {
  /// Creates loading.
  const NotificationsLoading();
}

/// Loaded with explicit list (empty list = empty state, not loading).
final class NotificationsLoaded extends NotificationsState {
  /// Creates loaded.
  const NotificationsLoaded([this.notifications = const []]);

  /// Notifications.
  final List<NotificationItem> notifications;

  @override
  List<Object?> get props => [notifications];
}

/// Load failed with message.
final class NotificationsFailure extends NotificationsState {
  /// Creates failure.
  const NotificationsFailure(this.message);

  /// Error message.
  final String message;

  @override
  List<Object?> get props => [message];
}
