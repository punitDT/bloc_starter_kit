import 'package:bloc_starter_kit/core/theme/app_decorations.dart';
import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.lg),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: colorScheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
        actionsPadding: const EdgeInsets.all(AppSpacing.md),
      ),
    );
  }
}
