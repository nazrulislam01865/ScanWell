import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:food_nutrient_app/features/auth/presentation/login_screen.dart';
import 'package:food_nutrient_app/features/auth/presentation/signup_screen.dart';
import 'package:food_nutrient_app/features/auth/presentation/verify_email_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/scan_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/product_search_screen.dart';
import 'package:food_nutrient_app/features/dashboard/presentation/contributor_dashboard_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/add_health_concern_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/health_profile_ready_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/personalized_product_alerts_setup_screen.dart';
import 'package:food_nutrient_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/possible_duplicate_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/product_camera_screen.dart';
import 'package:food_nutrient_app/features/settings/presentation/privacy_screen.dart';
import 'package:food_nutrient_app/features/settings/presentation/settings_screen.dart';

void main() {
  const deviceSizes = <Size>[
    Size(320, 568),
    Size(360, 640),
    Size(390, 844),
    Size(844, 390),
    Size(800, 1280),
  ];

  final screens = <String, Widget>{
    'onboarding': const OnboardingScreen(),
    'login': const LoginScreen(),
    'signup': const SignupScreen(),
    'verification': const VerifyEmailScreen(
      arguments: VerifyEmailArguments(email: 'aminul@gmail.com'),
    ),
    'home dashboard': const ContributorDashboardScreen(),
    'scan': const ScanScreen(),
    'product search': const ProductSearchScreen(),
    'settings': const SettingsScreen(),
    'privacy': const PrivacyScreen(),
    'personalized alerts setup': const PersonalizedProductAlertsSetupScreen(),
    'add health concern': const AddHealthConcernScreen(),
    'health profile ready': const HealthProfileReadyScreen(),
    'product camera': const ProductCameraScreen(),
    'possible duplicate': const PossibleDuplicateScreen(),
  };

  for (final entry in screens.entries) {
    testWidgets('${entry.key} has no overflow on supported sizes', (
      tester,
    ) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      for (final size in deviceSizes) {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;

        await tester.pumpWidget(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: entry.value,
          ),
        );
        await tester.pumpAndSettle();

        expect(
          tester.takeException(),
          isNull,
          reason: '${entry.key} overflowed at ${size.width} x ${size.height}',
        );

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      }
    });
  }
}
