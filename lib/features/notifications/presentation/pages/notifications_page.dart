import 'dart:async';

import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/widgets/error/error_widget.dart';
import 'package:bloc_starter_kit/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:bloc_starter_kit/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
      create: (_) {
        final cubit = getIt<NotificationsCubit>();
        unawaited(cubit.load());
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.notifications),
          actions: [
            Builder(
              builder: (actionContext) => IconButton(
                tooltip: actionContext.l10n.markAllRead,
                onPressed: () =>
                    actionContext.read<NotificationsCubit>().markAllRead(),
                icon: const Icon(Icons.done_all),
              ),
            ),
          ],
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) => switch (state) {
            NotificationsInitial() ||
            NotificationsLoading() =>
              const Center(
                child: CircularProgressIndicator(),
              ),
            NotificationsFailure(:final message) => EmptyStateWidget(
                icon: Icons.error_outline,
                title: message,
                message: message,
              ),
            NotificationsLoaded(:final notifications)
                when notifications.isEmpty =>
              EmptyStateWidget(
                icon: Icons.notifications_none,
                title: context.l10n.notificationEmpty,
                message: context.l10n.notificationEmptyMessage,
              ),
            NotificationsLoaded(:final notifications) => ListView.separated(
                itemCount: notifications.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1),
                itemBuilder: (context, index) =>
                    _NotificationTile(item: notifications[index]),
              ),
          },
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: context.colorScheme.primaryContainer,
        child: Icon(
          Icons.notifications_outlined,
          color: context.colorScheme.onPrimaryContainer,
          semanticLabel: 'Notification icon',
        ),
      ),
      title: Text(item.title),
      subtitle: Text(item.body),
      trailing: Text(item.time),
    );
  }
}
