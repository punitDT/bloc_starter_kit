import 'package:bloc_starter_kit/core/l10n/l10n_setup.dart';
import 'package:bloc_starter_kit/core/widgets/layout/max_width_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MaxWidthContainer constrains width on large screens',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: L10nSetup.localizationsDelegates,
        supportedLocales: L10nSetup.supportedLocales,
        home: Scaffold(
          body: MaxWidthContainer(child: Text('content')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('content'), findsOneWidget);
    expect(find.byType(MaxWidthContainer), findsOneWidget);
    expect(find.byType(ConstrainedBox), findsWidgets);
  });

  testWidgets('LayoutBuilder switches at breakpoint', (tester) async {
    Widget build(double width) => MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: width,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >
                      AppBreakpoints.largeScreenMinWidth) {
                    return const Text('large');
                  }
                  return const Text('small');
                },
              ),
            ),
          ),
        );

    await tester.pumpWidget(build(800));
    expect(find.text('large'), findsOneWidget);
    await tester.pumpWidget(build(400));
    expect(find.text('small'), findsOneWidget);
  });
}
