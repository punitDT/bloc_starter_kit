import 'dart:async';

import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/widgets/error/error_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = NotificationsCubit()..load();
  }

  @override
  void dispose() {
    unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.notifications),
          actions: [
            IconButton(
              tooltip: context.l10n.markAllRead,
              onPressed: () {},
              icon: const Icon(Icons.done_all),
            ),
          ],
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.notifications.isEmpty) {
              return EmptyStateWidget(
                icon: Icons.notifications_none,
                title: context.l10n.notificationEmpty,
                message: context.l10n.notificationEmptyMessage,
              );
            }
            return ListView.separated(
              itemCount: state.notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: context.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.notifications_outlined,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(notification.title),
                  subtitle: Text(notification.body),
                  trailing: Text(notification.time),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  void load() {
    emit(const NotificationsState(isLoading: true));
    emit(
      const NotificationsState(
        notifications: [
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
}

class NotificationsState extends Equatable {
  const NotificationsState({
    this.isLoading = false,
    this.notifications = const [],
  });

  final bool isLoading;
  final List<NotificationItem> notifications;

  @override
  List<Object?> get props => [isLoading, notifications];
}

class NotificationItem extends Equatable {
  const NotificationItem(this.title, this.body, this.time);

  final String title;
  final String body;
  final String time;

  @override
  List<Object?> get props => [title, body, time];
}
