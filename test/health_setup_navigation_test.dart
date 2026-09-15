import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/app/app.dart';
import 'package:food_nutrient_app/app/routes/app_routes.dart';

void main() {
  Future<void> openRoute(WidgetTester tester, String route) async {
    await tester.pumpWidget(const ScanWellApp());
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamed(route);
    await tester.pumpAndSettle();
  }

  testWidgets('health setup continues through all three steps before home', (
    tester,
  ) async {
    await openRoute(tester, AppRoutes.personalizedAlertSetup);

    expect(find.text('1 of 3'), findsOneWidget);
    await tester.tap(find.byKey(const Key('personalized-alerts-continue')));
    await tester.pumpAndSettle();

    expect(find.text('2 of 3'), findsOneWidget);
    await tester.tap(find.byKey(const Key('skip-health-concern')));
    await tester.pumpAndSettle();

    expect(find.text('3 of 3'), findsOneWidget);
    expect(find.text('Your health profile is ready'), findsOneWidget);

    await tester.tap(find.byKey(const Key('finish-health-setup')));
    await tester.pumpAndSettle();

    expect(find.text('What would you like to do?'), findsOneWidget);
  });

  testWidgets('submitting another concern advances to step three', (tester) async {
    await openRoute(tester, AppRoutes.addHealthConcern);

    await tester.enterText(
      find.byKey(const Key('health-concern-input')),
      'Migraine',
    );
    await tester.tap(find.byKey(const Key('submit-health-concern')));
    await tester.pumpAndSettle();

    expect(find.text('3 of 3'), findsOneWidget);
  });
}
