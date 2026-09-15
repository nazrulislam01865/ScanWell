import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:food_nutrient_app/features/auth/presentation/login_screen.dart';
import 'package:food_nutrient_app/features/auth/presentation/signup_screen.dart';
import 'package:food_nutrient_app/features/auth/presentation/verify_email_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/compare_products_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/personalized_alerts_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/product_detail_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/product_search_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/scan_screen.dart';
import 'package:food_nutrient_app/features/consumer/presentation/suggest_correction_screen.dart';
import 'package:food_nutrient_app/features/dashboard/presentation/contributor_dashboard_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/add_health_concern_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/health_profile_ready_screen.dart';
import 'package:food_nutrient_app/features/health_profile/presentation/personalized_product_alerts_setup_screen.dart';
import 'package:food_nutrient_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/admin_review_submission_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/possible_duplicate_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/processing_product_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/product_camera_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/review_extracted_data_screen.dart';
import 'package:food_nutrient_app/features/product_workflow/presentation/review_photo_screen.dart';
import 'package:food_nutrient_app/features/settings/presentation/privacy_screen.dart';
import 'package:food_nutrient_app/features/settings/presentation/settings_screen.dart';

void main() {
  final screens = <String, Widget>{
    'onboarding': const OnboardingScreen(),
    'login': const LoginScreen(),
    'signup': const SignupScreen(),
    'verify email': const VerifyEmailScreen(
      arguments: VerifyEmailArguments(email: 'test@example.com'),
    ),
    'dashboard': const ContributorDashboardScreen(),
    'scan': const ScanScreen(),
    'product search': const ProductSearchScreen(),
    'product detail': const ProductDetailScreen(),
    'compare products': const CompareProductsScreen(),
    'personalized alerts': const PersonalizedAlertsScreen(),
    'suggest correction': const SuggestCorrectionScreen(),
    'alerts setup': const PersonalizedProductAlertsSetupScreen(),
    'add health concern': const AddHealthConcernScreen(),
    'health profile ready': const HealthProfileReadyScreen(),
    'settings': const SettingsScreen(),
    'privacy': const PrivacyScreen(),
    'product camera': const ProductCameraScreen(),
    'review photo': const ReviewPhotoScreen(),
    'processing product': const ProcessingProductScreen(),
    'review extracted data': const ReviewExtractedDataScreen(),
    'possible duplicate': const PossibleDuplicateScreen(),
    'admin review': const AdminReviewSubmissionScreen(),
  };

  for (final entry in screens.entries) {
    testWidgets('${entry.key} builds after design-system migration', (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: entry.value,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        tester.takeException(),
        isNull,
        reason: '${entry.key} threw during initial rendering',
      );
    });
  }
}
