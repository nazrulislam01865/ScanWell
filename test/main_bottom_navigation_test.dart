import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/app/routes/app_routes.dart';
import 'package:food_nutrient_app/core/widgets/main_bottom_navigation.dart';

void main() {
  testWidgets('shows the same five destinations throughout the app', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          bottomNavigationBar: MainBottomNavigation(
            currentDestination: MainNavigationDestination.home,
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Scan'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Add Product'), findsNothing);
  });

  testWidgets('opens the scan destination from the shared navigation', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (_) => const Scaffold(
                body: Text('Home route'),
                bottomNavigationBar: MainBottomNavigation(
                  currentDestination: MainNavigationDestination.home,
                ),
              ),
          AppRoutes.scan: (_) => const Scaffold(body: Text('Scan route')),
        },
      ),
    );

    await tester.tap(find.text('Scan'));
    await tester.pumpAndSettle();

    expect(find.text('Scan route'), findsOneWidget);
  });
}
