import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomePage renders the Bloc Starter Kit title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: L10nSetup.localizationsDelegates,
        supportedLocales: L10nSetup.supportedLocales,
        home: HomePage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Bloc Starter Kit'), findsWidgets);
    expect(find.text('Production Starter Kit'), findsOneWidget);
  });
}
