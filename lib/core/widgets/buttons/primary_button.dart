import 'package:flutter/material.dart';

/// Filled primary action button.
class PrimaryButton extends StatelessWidget {
  /// Creates the button.
  const PrimaryButton({
    required this.onPressed,
    required this.label,
    super.key,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;

  /// Button label.
  final String label;

  /// Whether to show a spinner instead of [label].
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}
