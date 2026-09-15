import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/auth/presentation/verify_email_screen.dart';
import '../../features/consumer/presentation/scan_screen.dart';
import '../../features/consumer/data/product_detail_data.dart';
import '../../features/consumer/presentation/product_detail_screen.dart';
import '../../features/consumer/presentation/personalized_alerts_screen.dart';
import '../../features/consumer/presentation/product_search_screen.dart';
import '../../features/consumer/presentation/compare_products_screen.dart';
import '../../features/consumer/presentation/suggest_correction_screen.dart';
import '../../features/health_profile/presentation/add_health_concern_screen.dart';
import '../../features/health_profile/presentation/health_profile_ready_screen.dart';
import '../../features/health_profile/presentation/personalized_product_alerts_setup_screen.dart';
import '../../features/dashboard/presentation/contributor_dashboard_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/product_workflow/presentation/admin_review_submission_screen.dart';
import '../../features/product_workflow/presentation/processing_product_screen.dart';
import '../../features/product_workflow/presentation/product_camera_screen.dart';
import '../../features/product_workflow/presentation/possible_duplicate_screen.dart';
import '../../features/product_workflow/presentation/review_extracted_data_screen.dart';
import '../../features/product_workflow/presentation/review_photo_screen.dart';
import '../../features/settings/presentation/privacy_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const onboarding = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const verifyEmail = '/verify-email';
  static const home = '/home';
  static const scan = '/scan';
  static const productSearch = '/product-search';
  static const productDetail = '/product-detail';
  static const personalizedAlerts = '/personalized-alerts';
  static const personalizedAlertSetup = '/personalized-alert-setup';
  static const addHealthConcern = '/add-health-concern';
  static const healthProfileReady = '/health-profile-ready';
  static const compareProducts = '/compare-products';
  static const suggestCorrection = '/suggest-correction';
  static const productCamera = '/product-camera';
  static const reviewPhoto = '/review-photo';
  static const processingProduct = '/processing-product';
  static const possibleDuplicate = '/possible-duplicate';
  static const reviewExtractedData = '/review-extracted-data';
  static const reviewSubmission = '/review-submission';
  static const dashboard = '/dashboard';
  static const settings = '/settings';
  static const privacy = '/privacy';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onboarding:
        return _page(const OnboardingScreen(), routeSettings);

      case login:
        return _page(const LoginScreen(), routeSettings);

      case signup:
        return _page(const SignupScreen(), routeSettings);

      case verifyEmail:
        final arguments = routeSettings.arguments;
        final verifyArguments = arguments is VerifyEmailArguments
            ? arguments
            : const VerifyEmailArguments(email: 'aminul@gmail.com');

        return _page(
          VerifyEmailScreen(arguments: verifyArguments),
          routeSettings,
        );

      case home:
      case dashboard:
        return _page(
          const ContributorDashboardScreen(),
          routeSettings,
        );

      case scan:
        return _page(const ScanScreen(), routeSettings);

      case productSearch:
        return _page(const ProductSearchScreen(), routeSettings);

      case productDetail:
        final arguments = routeSettings.arguments;
        final initialTab = arguments is ProductDetailTab
            ? arguments
            : ProductDetailTab.overview;

        return _page(
          ProductDetailScreen(initialTab: initialTab),
          routeSettings,
        );

      case personalizedAlerts:
        return _page(const PersonalizedAlertsScreen(), routeSettings);

      case personalizedAlertSetup:
        return _page(
          const PersonalizedProductAlertsSetupScreen(),
          routeSettings,
        );

      case addHealthConcern:
        return _page(const AddHealthConcernScreen(), routeSettings);

      case healthProfileReady:
        return _page(const HealthProfileReadyScreen(), routeSettings);

      case compareProducts:
        return _page(const CompareProductsScreen(), routeSettings);

      case suggestCorrection:
        return _page(const SuggestCorrectionScreen(), routeSettings);

      case productCamera:
        return _page(const ProductCameraScreen(), routeSettings);

      case reviewPhoto:
        return _page(const ReviewPhotoScreen(), routeSettings);

      case processingProduct:
        return _page(const ProcessingProductScreen(), routeSettings);

      case possibleDuplicate:
        return _page(const PossibleDuplicateScreen(), routeSettings);

      case reviewExtractedData:
        return _page(const ReviewExtractedDataScreen(), routeSettings);

      case reviewSubmission:
        return _page(const AdminReviewSubmissionScreen(), routeSettings);

      case settings:
        return _page(const SettingsScreen(), routeSettings);

      case privacy:
        return _page(const PrivacyScreen(), routeSettings);

      default:
        return _page(const OnboardingScreen(), routeSettings);
    }
  }

  static MaterialPageRoute<dynamic> _page(
    Widget child,
    RouteSettings settings,
  ) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => child,
      settings: settings,
    );
  }
}
