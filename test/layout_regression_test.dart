import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:food_nutrient_app/features/auth/presentation/signup_screen.dart';
import 'package:food_nutrient_app/features/dashboard/presentation/contributor_dashboard_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/personalized_product_alerts_setup_screen.dart';
import 'package:food_nutrient_app/features/settings/presentation/settings_screen.dart';

void main() {
  const phoneSizes = <Size>[
    Size(320, 568),
    Size(360, 800),
    Size(375, 812),
    Size(390, 844),
    Size(412, 915),
  ];

  Future<void> pumpAt(
    WidgetTester tester,
    Widget screen,
    Size size,
  ) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: screen),
    );
    await tester.pumpAndSettle();
  }

  for (final size in phoneSizes) {
    testWidgets('reported screens do not overflow at ${size.width}px', (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      for (final screen in <Widget>[
        const SignupScreen(),
        const ContributorDashboardScreen(),
        const SettingsScreen(),
        const PersonalizedProductAlertsSetupScreen(),
      ]) {
        await pumpAt(tester, screen, size);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      }
    });
  }

  testWidgets('signup auth selector keeps OTP login option visible', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpAt(tester, const SignupScreen(), const Size(360, 800));

    final otp = tester.widget<Text>(find.text('OTP login option'));
    expect(otp.maxLines, 1);
    expect(otp.overflow, isNot(TextOverflow.ellipsis));
  });

  testWidgets('health concern labels are not ellipsized', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await pumpAt(
      tester,
      const PersonalizedProductAlertsSetupScreen(),
      const Size(360, 800),
    );

    for (final label in <String>[
      'Diabetes',
      'High blood pressure',
      'Kidney concern',
      'High cholesterol',
    ]) {
      final text = tester.widget<Text>(find.text(label));
      expect(text.overflow, isNot(TextOverflow.ellipsis));
    }
  });
}
