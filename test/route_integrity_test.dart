import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/app/routes/app_routes.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';

void main() {
  const routes = <String>[
    AppRoutes.onboarding,
    AppRoutes.login,
    AppRoutes.signup,
    AppRoutes.verifyEmail,
    AppRoutes.home,
    AppRoutes.dashboard,
    AppRoutes.scan,
    AppRoutes.productSearch,
    AppRoutes.productDetail,
    AppRoutes.personalizedAlerts,
    AppRoutes.personalizedAlertSetup,
    AppRoutes.addHealthConcern,
    AppRoutes.healthProfileReady,
    AppRoutes.compareProducts,
    AppRoutes.suggestCorrection,
    AppRoutes.productCamera,
    AppRoutes.reviewPhoto,
    AppRoutes.processingProduct,
    AppRoutes.possibleDuplicate,
    AppRoutes.reviewExtractedData,
    AppRoutes.reviewSubmission,
    AppRoutes.settings,
    AppRoutes.privacy,
  ];

  for (final routeName in routes) {
    testWidgets('$routeName resolves to a real screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: routeName,
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.takeException(), isNull);
      expect(find.byType(Scaffold), findsWidgets);
    });
  }
}
