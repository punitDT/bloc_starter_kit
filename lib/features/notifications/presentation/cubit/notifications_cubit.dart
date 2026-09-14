import 'package:bloc_starter_kit/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Demo notification entity.
class NotificationItem extends Equatable {
  /// Creates a notification.
  const NotificationItem(this.title, this.body, this.time);

  /// Title.
  final String title;

  /// Body.
  final String body;

  /// Relative time label.
  final String time;

  @override
  List<Object?> get props => [title, body, time];
}

/// Loads demo notifications with explicit loading/success/failure states.
@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  /// Creates the cubit.
  NotificationsCubit() : super(const NotificationsInitial());

  /// Loads notifications.
  Future<void> load() async {
    emit(const NotificationsLoading());
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(
      const NotificationsLoaded(
        [
          NotificationItem('Welcome', 'Your app is set up', 'now'),
          NotificationItem(
            'Architecture ready',
            'Feature-first clean architecture scaffolded',
            '2m ago',
          ),
        ],
      ),
    );
  }

  /// Clears all notifications.
  void markAllRead() => emit(const NotificationsLoaded());
}
