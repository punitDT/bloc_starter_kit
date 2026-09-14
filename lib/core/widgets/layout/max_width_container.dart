import 'package:bloc_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Breakpoints based on available width, not device type.
abstract final class AppBreakpoints {
  /// Minimum width for large-screen (tablet/desktop) layouts.
  static const double largeScreenMinWidth = 600;

  /// Maximum content width for forms and text on large screens.
  static const double maxContentWidth = 480;
}

/// Centers content and constrains width on large screens.
///
/// Wrap forms and text blocks so they do not stretch unnaturally on
/// tablet/desktop. Uses [LayoutBuilder] constraints via parent.
class MaxWidthContainer extends StatelessWidget {
  /// Creates the container.
  const MaxWidthContainer({
    required this.child,
    this.maxWidth = AppBreakpoints.maxContentWidth,
    super.key,
  });

  /// Content to constrain.
  final Widget child;

  /// Maximum width applied inside a [ConstrainedBox].
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
    );
  }
}
