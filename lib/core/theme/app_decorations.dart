import 'package:flutter/material.dart';

/// Border radius scale.
abstract final class AppBorderRadius {
  static const BorderRadius none = BorderRadius.zero;
  static const BorderRadius sm = BorderRadius.all(Radius.circular(4));
  static const BorderRadius md = BorderRadius.all(Radius.circular(8));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(24));
  static const BorderRadius full = BorderRadius.all(Radius.circular(9999));
}

/// Shadow / elevation tokens.
abstract final class AppShadows {
  static const List<BoxShadow> none = [];
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
  ];
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x24000000),
      blurRadius: 3,
      offset: Offset(0, 2),
    ),
  ];
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
}

/// Animation duration tokens.
abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}
