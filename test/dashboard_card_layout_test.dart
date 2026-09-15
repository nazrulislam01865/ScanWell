import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:food_nutrient_app/features/dashboard/presentation/contributor_dashboard_screen.dart';

void main() {
  Future<void> pumpDashboard(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const ContributorDashboardScreen(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('phone dashboard keeps both card families horizontally browsable',
      (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpDashboard(tester, const Size(360, 800));

    final statsScroll = tester.widget<SingleChildScrollView>(
      find.byKey(const ValueKey('dashboard-stats-scroll')),
    );
    final actionsScroll = tester.widget<SingleChildScrollView>(
      find.byKey(const ValueKey('dashboard-actions-scroll')),
    );

    expect(statsScroll.scrollDirection, Axis.horizontal);
    expect(actionsScroll.scrollDirection, Axis.horizontal);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all statistic cards share one size and all action cards share one size',
      (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpDashboard(tester, const Size(360, 800));

    final statSizes = List.generate(
      4,
      (index) => tester.getSize(
        find.byKey(ValueKey('dashboard-stat-card-$index')),
      ),
    );
    final actionSizes = List.generate(
      3,
      (index) => tester.getSize(
        find.byKey(ValueKey('dashboard-action-card-$index')),
      ),
    );

    expect(statSizes.toSet(), hasLength(1));
    expect(actionSizes.toSet(), hasLength(1));
    expect(statSizes.first.width, AppSizes.dashboardStatCardWidth);
    expect(statSizes.first.height, AppSizes.dashboardStatCardHeight);
    expect(actionSizes.first.width, AppSizes.dashboardActionCardWidth);
    expect(actionSizes.first.height, AppSizes.dashboardActionCardHeight);
    expect(actionSizes.first.width, greaterThan(statSizes.first.width));
    expect(tester.takeException(), isNull);
  });

  testWidgets('wide dashboard keeps each card family in one equal-width row',
      (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpDashboard(tester, const Size(620, 900));

    expect(find.byKey(const ValueKey('dashboard-stats-scroll')), findsNothing);
    expect(find.byKey(const ValueKey('dashboard-actions-scroll')), findsNothing);

    final statSizes = List.generate(
      4,
      (index) => tester.getSize(
        find.byKey(ValueKey('dashboard-stat-card-$index')),
      ),
    );
    final actionSizes = List.generate(
      3,
      (index) => tester.getSize(
        find.byKey(ValueKey('dashboard-action-card-$index')),
      ),
    );

    expect(statSizes.map((size) => size.width).toSet(), hasLength(1));
    expect(actionSizes.map((size) => size.width).toSet(), hasLength(1));
    expect(tester.takeException(), isNull);
  });
}
