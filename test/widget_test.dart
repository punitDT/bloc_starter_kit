// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_starter_kit/core/config/app_config.dart';

void main() {
  test('starter app config is initialized', () {
    expect(AppConfig.appName, 'Bloc Starter Kit');
    expect(AppConfig.baseUrl, contains('jsonplaceholder'));
  });
}
