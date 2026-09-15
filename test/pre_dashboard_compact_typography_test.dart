import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:food_nutrient_app/features/auth/presentation/signup_screen.dart';
import 'package:food_nutrient_app/features/auth/presentation/verify_email_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/add_health_concern_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/health_profile_ready_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/personalized_product_alerts_setup_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );
  }

  setUp(() {
    // The pre-dashboard visual contract is intentionally denser than the
    // post-login dashboard while preserving readable minimum sizes.
    expect(AppTextStyles.preDashboardTitleFor(compact: true).fontSize, 20);
    expect(AppTextStyles.preDashboardTitleFor(compact: false).fontSize, 22);
    expect(AppTextStyles.preDashboardBodyFor(compact: true).fontSize, 13);
    expect(AppTextStyles.preDashboardBodyFor(compact: false).fontSize, 14);
    expect(AppTextStyles.authFieldLabel.fontSize, 13.5);
    expect(AppTextStyles.authInputText.fontSize, 14);
    expect(AppTextStyles.preDashboardButtonLabel.fontSize, 14.5);
  });

  testWidgets('signup uses responsive Flutter header text', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const SignupScreen()));
    await tester.pump();

    final title = tester.widget<Text>(find.text('Create your account'));
    expect(title.style?.fontSize, lessThanOrEqualTo(22));
    expect(title.style?.fontWeight, AppTypography.weight700);
    expect(find.text('Start scanning products and get health flags that matter to you.'), findsOneWidget);
  });

  testWidgets('verify email uses compact header and OTP typography', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      wrap(
        const VerifyEmailScreen(
          arguments: VerifyEmailArguments(email: 'test@example.com'),
        ),
      ),
    );
    await tester.pump();

    final title = tester.widget<Text>(find.text('Verify your email'));
    expect(title.style?.fontSize, lessThanOrEqualTo(22));
    expect(find.textContaining('Enter the 6-digit code'), findsOneWidget);
  });

  testWidgets('health setup screens share compact page title hierarchy', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const PersonalizedProductAlertsSetupScreen()));
    await tester.pump();
    var title = tester.widget<Text>(find.text('Do you want personalized product alerts?'));
    expect(title.style?.fontSize, lessThanOrEqualTo(22));

    await tester.pumpWidget(wrap(const AddHealthConcernScreen()));
    await tester.pump();
    title = tester.widget<Text>(find.text('Add another health concern'));
    expect(title.style?.fontSize, lessThanOrEqualTo(22));

    await tester.pumpWidget(wrap(const HealthProfileReadyScreen()));
    await tester.pump();
    title = tester.widget<Text>(find.text('Your health profile is ready'));
    expect(title.style?.fontSize, lessThanOrEqualTo(22));
  });
}
