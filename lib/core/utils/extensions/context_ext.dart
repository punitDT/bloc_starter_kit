import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextX on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;
}

extension NavigationX on BuildContext {
  void goNamed(String name, {Object? extra}) =>
      GoRouter.of(this).goNamed(name, extra: extra);
  void pushNamed(String name, {Object? extra}) =>
      GoRouter.of(this).pushNamed(name, extra: extra);
  void pop() => GoRouter.of(this).pop();
}
