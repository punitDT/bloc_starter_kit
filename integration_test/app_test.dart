import 'package:bloc_starter_kit/app.dart';
import 'package:bloc_starter_kit/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App smoke', () {
    testWidgets('boots to splash/home shell', (tester) async {
      await configureDependencies();
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
