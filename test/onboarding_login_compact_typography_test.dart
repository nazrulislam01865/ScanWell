import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:food_nutrient_app/features/auth/presentation/login_screen.dart';
import 'package:food_nutrient_app/features/onboarding/presentation/onboarding_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: child,
    );
  }

  testWidgets('onboarding uses compact readable typography', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const OnboardingScreen()));
    await tester.pumpAndSettle();

    final stepText = tester.widget<Text>(find.text('1 of 3'));
    final titleText = tester.widget<Text>(find.text('Scan packaged products'));
    final descriptionText = tester.widget<Text>(
      find.text(
        'Scan barcode, nutrition label, and ingredients\n'
        'to quickly understand what is inside your food.',
      ),
    );

    expect(stepText.style?.fontSize, lessThanOrEqualTo(14));
    expect(stepText.style?.fontWeight, AppTypography.weight500);
    expect(titleText.style?.fontSize, lessThanOrEqualTo(24));
    expect(titleText.style?.fontWeight, AppTypography.weight700);
    expect(descriptionText.style?.fontSize, lessThanOrEqualTo(15));

    final getStarted = tester.widget<Text>(find.text('Get Started'));
    expect(getStarted.style?.fontSize, lessThanOrEqualTo(16));
    expect(getStarted.style?.fontWeight, AppTypography.weight600);
  });

  testWidgets('login header text is responsive Flutter text', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const LoginScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(
      find.text(
        'Log in to view scan history, saved products, and personalized health flags.',
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('login-illustration')), findsOneWidget);

    final heading = tester.widget<Text>(find.text('Welcome back'));
    expect(heading.style?.fontSize, lessThanOrEqualTo(24));
    expect(heading.style?.fontWeight, AppTypography.weight700);

    final logIn = tester.widget<Text>(find.text('Log In'));
    expect(logIn.style?.fontSize, lessThanOrEqualTo(16));
    expect(logIn.style?.fontWeight, AppTypography.weight600);
  });
}
