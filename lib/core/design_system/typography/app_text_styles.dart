import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_shadows.dart';
import 'app_typography.dart';

/// Visual variants for page-level headings. The variants preserve ScanWell's
/// existing responsive measurements while giving every page a semantic entry
/// point instead of assembling font primitives locally.
enum AppPageTitleVariant {
  standard,
  comparison,
  search,
  settings,
  centered,
  tight,
  prominent,
  prominentNarrow,
  reviewOnDark,
  cameraOnDark,
}

/// Semantic typography used by screens and reusable components.
///
/// [AppTypography] remains the primitive compatibility layer. Feature UI should
/// prefer these roles so product-wide typography changes are made here once.
abstract final class AppTextStyles {
  AppTextStyles._();

  static const displayLarge = AppTextStyle(
    fontSize: AppTypography.font36,
    fontWeight: AppTypography.weight800,
    height: AppTypography.lineHeight1_12,
    letterSpacing: AppTypography.letterSpacingn0_7,
  );

  static const displayMedium = AppTextStyle(
    fontSize: AppTypography.font32,
    fontWeight: AppTypography.weight900,
    height: AppTypography.lineHeight1_05,
    letterSpacing: AppTypography.letterSpacingn1,
  );

  static const pageTitleLarge = AppTextStyle(
    fontSize: AppTypography.font35,
    fontWeight: AppTypography.weight800,
    height: AppTypography.lineHeight1_1,
  );

  static const pageTitleLargeCompact = AppTextStyle(
    fontSize: AppTypography.font31,
    fontWeight: AppTypography.weight800,
    height: AppTypography.lineHeight1_1,
  );

  static const pageTitle = AppTextStyle(
    fontSize: AppTypography.font29,
    fontWeight: AppTypography.weight800,
    height: AppTypography.lineHeight1_05,
  );

  static const pageTitleCompact = AppTextStyle(
    fontSize: AppTypography.font26,
    fontWeight: AppTypography.weight800,
    height: AppTypography.lineHeight1_05,
  );

  static const pageTitleTight = AppTextStyle(
    fontSize: AppTypography.font31,
    fontWeight: AppTypography.weight800,
    height: AppTypography.lineHeight1_08,
    letterSpacing: AppTypography.letterSpacingn0_55,
  );

  static const pageTitleTightCompact = AppTextStyle(
    fontSize: AppTypography.font27,
    fontWeight: AppTypography.weight800,
    height: AppTypography.lineHeight1_08,
    letterSpacing: AppTypography.letterSpacingn0_55,
  );

  static TextStyle onboardingStepFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font12 : AppTypography.font13,
        fontWeight: AppTypography.weight500,
        height: AppTypography.lineHeight1_25,
        color: AppColors.primary,
      );

  static TextStyle onboardingTitleFor({required bool compact}) =>
      preDashboardTitleFor(compact: compact);

  static TextStyle onboardingBodyFor({required bool compact}) =>
      preDashboardBodyFor(compact: compact);

  /// Compact page title used only by the onboarding/auth/health-setup flow.
  /// Dashboard and post-login page title metrics intentionally remain unchanged.
  static TextStyle preDashboardTitleFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font20 : AppTypography.font22,
        fontWeight: AppTypography.weight700,
        height: AppTypography.lineHeight1_2,
        letterSpacing: compact
            ? AppTypography.letterSpacingn0_2
            : AppTypography.letterSpacingn0_25,
        color: AppColors.textPrimary,
      );

  static TextStyle preDashboardBodyFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font13 : AppTypography.font14,
        fontWeight: AppTypography.weight400,
        height: AppTypography.lineHeight1_4,
        color: AppColors.textSecondary,
      );

  static TextStyle authHeroTitleFor({required bool compact}) =>
      preDashboardTitleFor(compact: compact);

  static TextStyle authHeroBodyFor({required bool compact}) =>
      preDashboardBodyFor(compact: compact);

  // Compatibility aliases for the existing login tests/call sites.
  static TextStyle loginHeroTitleFor({required bool compact}) =>
      authHeroTitleFor(compact: compact);

  static TextStyle loginHeroBodyFor({required bool compact}) =>
      authHeroBodyFor(compact: compact);

  static TextStyle authBrandTaglineFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font10_5 : AppTypography.font11_5,
        fontWeight: AppTypography.weight500,
        height: AppTypography.lineHeight1_25,
        color: AppColors.textSecondary,
      );

  static const authFieldLabel = AppTextStyle(
    fontSize: AppTypography.font13_5,
    fontWeight: AppTypography.weight600,
    color: AppColors.textPrimary,
  );

  static const authInputText = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight400,
    color: AppColors.textPrimary,
  );

  static const authInputHint = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight400,
    color: AppColors.textSecondary,
  );

  static const authInlineText = AppTextStyle(
    fontSize: AppTypography.font13_5,
    fontWeight: AppTypography.weight400,
    color: AppColors.textPrimary,
  );

  static const authLink = AppTextStyle(
    fontSize: AppTypography.font13_5,
    fontWeight: AppTypography.weight600,
    color: AppColors.primary,
  );

  static const preDashboardSectionTitle = AppTextStyle(
    fontSize: AppTypography.font14_5,
    fontWeight: AppTypography.weight600,
    height: AppTypography.lineHeight1_2,
    color: AppColors.textPrimary,
  );

  static const preDashboardCardTitle = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight700,
    height: AppTypography.lineHeight1_2,
    color: AppColors.textPrimary,
  );

  static const preDashboardSupporting = AppTextStyle(
    fontSize: AppTypography.font13,
    fontWeight: AppTypography.weight400,
    height: AppTypography.lineHeight1_4,
    color: AppColors.textSecondary,
  );

  static const healthSetupStep = AppTextStyle(
    fontSize: AppTypography.font13,
    fontWeight: AppTypography.weight600,
    height: AppTypography.lineHeight1_2,
    color: AppColors.primary,
  );

  static const preDashboardButtonLabel = AppTextStyle(
    fontSize: AppTypography.font14_5,
    fontWeight: AppTypography.weight600,
  );

  static TextStyle authOtpDigitFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font18 : AppTypography.font20,
        fontWeight: AppTypography.weight600,
        color: AppColors.primary,
      );

  // Product detail semantic typography. Keep product information compact while
  // preserving a clear hierarchy across Overview, Health Flags, Nutrition,
  // Ingredients, and Alternatives.
  static TextStyle productDetailTitleFor({
    required bool compact,
    bool dense = false,
  }) => AppTextStyle(
        fontSize: dense
            ? (compact ? AppTypography.font15_5 : AppTypography.font16_5)
            : (compact ? AppTypography.font17 : AppTypography.font18),
        fontWeight: AppTypography.weight600,
        height: AppTypography.lineHeight1_15,
        letterSpacing: AppTypography.letterSpacingn0_2,
        color: AppColors.textPrimary,
      );

  static const productDetailBrand = AppTextStyle(
    color: AppColors.primaryDark,
    fontSize: AppTypography.font12_5,
    height: AppTypography.lineHeight1_2,
    fontWeight: AppTypography.weight600,
  );

  static const productDetailSectionTitle = AppTextStyle(
    fontSize: AppTypography.font16,
    height: AppTypography.lineHeight1_2,
    fontWeight: AppTypography.weight700,
    color: AppColors.textPrimary,
  );

  static const productDetailSectionSubtitle = AppTextStyle(
    fontSize: AppTypography.font12_5,
    height: AppTypography.lineHeight1_35,
    fontWeight: AppTypography.weight400,
    color: AppColors.textSecondary,
  );

  static const productDetailCardTitle = AppTextStyle(
    fontSize: AppTypography.font13_5,
    height: AppTypography.lineHeight1_2,
    fontWeight: AppTypography.weight700,
    color: AppColors.textPrimary,
  );

  static const productDetailBody = AppTextStyle(
    fontSize: AppTypography.font13,
    height: AppTypography.lineHeight1_4,
    fontWeight: AppTypography.weight400,
    color: AppColors.textStrong,
  );

  static const productDetailSupporting = AppTextStyle(
    fontSize: AppTypography.font12,
    height: AppTypography.lineHeight1_35,
    fontWeight: AppTypography.weight400,
    color: AppColors.textSecondary,
  );

  static const productDetailIngredientBody = AppTextStyle(
    fontSize: AppTypography.font13_5,
    height: AppTypography.lineHeight1_45,
    fontWeight: AppTypography.weight400,
    color: AppColors.textInk,
  );

  static const productDetailIngredientEmphasis = AppTextStyle(
    fontSize: AppTypography.font13_5,
    height: AppTypography.lineHeight1_45,
    fontWeight: AppTypography.weight600,
    color: AppColors.textInk,
    decoration: TextDecoration.underline,
    decorationThickness: AppTypography.decorationThickness1_6,
  );

  static const productDetailInlineStrong = AppTextStyle(
    fontSize: AppTypography.font11_5,
    height: AppTypography.lineHeight1_25,
    fontWeight: AppTypography.weight700,
    color: AppColors.textStrong,
  );

  static const productDetailMeta = AppTextStyle(
    fontSize: AppTypography.font11,
    height: AppTypography.lineHeight1_3,
    fontWeight: AppTypography.weight400,
    color: AppColors.textSecondary,
  );

  static const productDetailBadge = AppTextStyle(
    fontSize: AppTypography.font10_5,
    height: AppTypography.lineHeight1_2,
    fontWeight: AppTypography.weight500,
  );

  static const productDetailMetricLabel = AppTextStyle(
    fontSize: AppTypography.font10,
    height: AppTypography.lineHeight1_2,
    fontWeight: AppTypography.weight600,
    color: AppColors.textStrong,
  );

  static const productDetailMetricValue = AppTextStyle(
    fontSize: AppTypography.font17,
    height: AppTypography.lineHeight1_05,
    fontWeight: AppTypography.weight700,
    color: AppColors.textPrimary,
  );

  static const productDetailMetricStatus = AppTextStyle(
    fontSize: AppTypography.font10_5,
    height: AppTypography.lineHeight1_2,
    fontWeight: AppTypography.weight600,
  );

  static const productDetailHealthLabel = AppTextStyle(
    fontSize: AppTypography.font12,
    height: AppTypography.lineHeight1_2,
    fontWeight: AppTypography.weight600,
    color: AppColors.textPrimary,
  );

  static TextStyle productDetailHealthStatusFor({
    required bool compact,
    Color color = AppColors.amber,
  }) => const AppTextStyle(
        fontSize: AppTypography.font16,
        height: AppTypography.lineHeight1_12,
        fontWeight: AppTypography.weight600,
        letterSpacing: AppTypography.letterSpacingn0_2,
      ).copyWith(color: color);

  static TextStyle productDetailScoreFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font24 : AppTypography.font26,
        height: AppTypography.lineHeight1,
        fontWeight: AppTypography.weight700,
        letterSpacing: AppTypography.letterSpacingn0_35,
        color: AppColors.textPrimary,
      );

  static const productDetailScoreCaption = AppTextStyle(
    fontSize: AppTypography.font9_5,
    fontWeight: AppTypography.weight400,
    color: AppColors.textStrong,
  );

  static TextStyle productDetailTabFor({
    required bool compact,
    required bool selected,
    required Color color,
  }) => AppTextStyle(
        color: color,
        fontSize: compact ? AppTypography.font10 : AppTypography.font10_5,
        fontWeight: selected ? AppTypography.weight600 : AppTypography.weight500,
      );

  static const productDetailActionLabel = AppTextStyle(
    fontSize: AppTypography.font13_5,
    fontWeight: AppTypography.weight600,
    height: AppTypography.lineHeight1_2,
  );

  // Profile / settings semantic typography. The profile page deliberately uses
  // a calmer scale than dashboard marketing-style headings.
  static TextStyle profilePageTitleFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font22 : AppTypography.font24,
        height: AppTypography.lineHeight1_15,
        fontWeight: AppTypography.weight700,
        letterSpacing: AppTypography.letterSpacingn0_25,
        color: AppColors.textPrimary,
      );

  static TextStyle profilePageBodyFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font13 : AppTypography.font14,
        height: AppTypography.lineHeight1_4,
        fontWeight: AppTypography.weight400,
        color: AppColors.textSecondary,
      );

  static TextStyle profileNameFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font17 : AppTypography.font19,
        height: AppTypography.lineHeight1_2,
        fontWeight: AppTypography.weight700,
        color: AppColors.textPrimary,
      );

  static TextStyle profileEmailFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font12_5 : AppTypography.font13_5,
        height: AppTypography.lineHeight1_3,
        fontWeight: AppTypography.weight400,
        color: AppColors.textSecondary,
      );

  static TextStyle profileMenuLabelFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font14 : AppTypography.font15,
        height: AppTypography.lineHeight1_2,
        fontWeight: AppTypography.weight500,
        color: AppColors.textPrimary,
      );

  static TextStyle profileMenuValueFor({required bool compact}) => AppTextStyle(
        fontSize: compact ? AppTypography.font12_5 : AppTypography.font13_5,
        height: AppTypography.lineHeight1_2,
        fontWeight: AppTypography.weight500,
        color: AppColors.textSecondary,
      );

  static const profilePrivacyNote = AppTextStyle(
    fontSize: AppTypography.font13,
    height: AppTypography.lineHeight1_35,
    fontWeight: AppTypography.weight500,
    color: AppColors.textPrimary,
  );

  /// Page title resolver used by responsive screens.
  ///
  /// Keep title geometry here. Product-wide title changes therefore require a
  /// single edit, while the variants retain the exact current screen metrics.
  static TextStyle pageTitleFor({
    required bool compact,
    AppPageTitleVariant variant = AppPageTitleVariant.standard,
    Color? color,
  }) {
    final TextStyle style;

    switch (variant) {
      case AppPageTitleVariant.standard:
        style = compact ? pageTitleCompact : pageTitle;
      case AppPageTitleVariant.comparison:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font25 : AppTypography.font29,
          height: AppTypography.lineHeight1,
          fontWeight: AppTypography.weight800,
          letterSpacing: AppTypography.letterSpacingn0_7,
        );
      case AppPageTitleVariant.search:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font26 : AppTypography.font30,
          height: AppTypography.lineHeight1,
          fontWeight: AppTypography.weight800,
          letterSpacing: AppTypography.letterSpacingn0_6,
        );
      case AppPageTitleVariant.settings:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font31 : AppTypography.font35,
          height: AppTypography.lineHeight1_1,
          fontWeight: AppTypography.weight800,
          letterSpacing: compact
              ? AppTypography.letterSpacingn0_5
              : AppTypography.letterSpacingn0_8,
        );
      case AppPageTitleVariant.centered:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font27 : AppTypography.font31,
          height: AppTypography.lineHeight1_16,
          fontWeight: AppTypography.weight800,
          letterSpacing: compact
              ? AppTypography.letterSpacingn0_5
              : AppTypography.letterSpacingn0_8,
        );
      case AppPageTitleVariant.tight:
        style = compact ? pageTitleTightCompact : pageTitleTight;
      case AppPageTitleVariant.prominent:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font31 : AppTypography.font36,
          height: AppTypography.lineHeight1_12,
          fontWeight: AppTypography.weight800,
          letterSpacing: AppTypography.letterSpacingn0_7,
        );
      case AppPageTitleVariant.prominentNarrow:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font28 : AppTypography.font36,
          height: AppTypography.lineHeight1_12,
          fontWeight: AppTypography.weight800,
          letterSpacing: AppTypography.letterSpacingn0_7,
        );
      case AppPageTitleVariant.reviewOnDark:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font26 : AppTypography.font29,
          height: AppTypography.lineHeight1_05,
          fontWeight: AppTypography.weight700,
          letterSpacing: AppTypography.letterSpacingn0_5,
        );
      case AppPageTitleVariant.cameraOnDark:
        style = AppTextStyle(
          fontSize: compact ? AppTypography.font24 : AppTypography.font29,
          height: AppTypography.lineHeight1_15,
          fontWeight: AppTypography.weight700,
          letterSpacing: AppTypography.letterSpacingn0_45,
          shadows: AppShadows.cameraInstructionText,
        );
    }

    return color == null ? style : style.copyWith(color: color);
  }

  static const sectionTitleLarge = AppTextStyle(
    fontSize: AppTypography.font20,
    fontWeight: AppTypography.weight900,
  );

  static const sectionTitleStrong = AppTextStyle(
    fontSize: AppTypography.font18,
    fontWeight: AppTypography.weight900,
  );

  static const sectionTitleMedium = AppTextStyle(
    fontSize: AppTypography.font17,
    fontWeight: AppTypography.weight800,
  );

  static const sectionTitle = AppTextStyle(
    fontSize: AppTypography.font18,
    fontWeight: AppTypography.weight800,
  );

  static const sectionTitleSmall = AppTextStyle(
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight800,
  );

  static const sectionTitleDense = AppTextStyle(
    fontSize: AppTypography.font15_5,
    fontWeight: AppTypography.weight800,
  );

  static const sectionTitleCompact = AppTextStyle(
    fontSize: AppTypography.font13,
    fontWeight: AppTypography.weight800,
  );

  static const workflowTitle = AppTextStyle(
    fontSize: AppTypography.font20,
    height: AppTypography.lineHeight1_1,
    fontWeight: AppTypography.weight800,
    letterSpacing: AppTypography.letterSpacingn0_3,
  );

  static const workflowSectionTitle = AppTextStyle(
    color: AppColors.primaryDark,
    fontSize: AppTypography.font17,
    height: AppTypography.lineHeight1_1,
    fontWeight: AppTypography.weight800,
  );

  static const workflowSubtitle = AppTextStyle(
    color: AppColors.textSecondary,
    fontSize: AppTypography.font11_5,
    height: AppTypography.lineHeight1_1,
  );

  static const cardTitle = AppTextStyle(
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight700,
  );

  static const cardTitleSmall = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight700,
  );

  static const labelLarge = AppTextStyle(
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight700,
  );

  static const labelMedium = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight600,
  );

  static const labelSmall = AppTextStyle(
    fontSize: AppTypography.font12,
    fontWeight: AppTypography.weight600,
  );

  static const supportingText = AppTextStyle(
    fontSize: AppTypography.font13,
    fontWeight: AppTypography.weight400,
    color: AppColors.textSecondary,
  );

  static const bodyLarge = AppTextStyle(
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight400,
    height: AppTypography.lineHeight1_4,
  );

  static const bodyMedium = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight400,
    height: AppTypography.lineHeight1_4,
  );

  static const bodySmall = AppTextStyle(
    fontSize: AppTypography.font12,
    fontWeight: AppTypography.weight400,
    height: AppTypography.lineHeight1_35,
  );

  static const caption = AppTextStyle(
    fontSize: AppTypography.font11,
    fontWeight: AppTypography.weight400,
    height: AppTypography.lineHeight1_3,
    color: AppColors.textSecondary,
  );

  static const micro = AppTextStyle(
    fontSize: AppTypography.font10,
    fontWeight: AppTypography.weight400,
    height: AppTypography.lineHeight1_25,
    color: AppColors.textSecondary,
  );

  static const buttonLabelLarge = AppTextStyle(
    fontSize: AppTypography.font18,
    fontWeight: AppTypography.weight700,
  );

  static const buttonLabel = AppTextStyle(
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight700,
  );

  static const buttonLabelSmall = AppTextStyle(
    fontSize: AppTypography.font12,
    fontWeight: AppTypography.weight700,
  );

  static const inlineAction = AppTextStyle(
    fontSize: AppTypography.font13,
    fontWeight: AppTypography.weight800,
  );

  static const compactAction = AppTextStyle(
    fontSize: AppTypography.font12_5,
    fontWeight: AppTypography.weight600,
  );

  static const sectionAction = AppTextStyle(
    fontSize: AppTypography.font12,
    fontWeight: AppTypography.weight700,
  );

  static const galleryAction = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight500,
  );

  static const microButtonLabel = AppTextStyle(
    fontSize: AppTypography.font10,
    fontWeight: AppTypography.weight700,
  );

  static const tinyAction = AppTextStyle(
    fontSize: AppTypography.font10_5,
    fontWeight: AppTypography.weight700,
  );

  static const adminButtonLabel = AppTextStyle(
    fontSize: AppTypography.font14,
    fontWeight: AppTypography.weight700,
  );

  static const detailActionCompact = AppTextStyle(
    fontSize: AppTypography.font13,
    fontWeight: AppTypography.weight800,
  );

  static const detailAction = AppTextStyle(
    fontSize: AppTypography.font15,
    fontWeight: AppTypography.weight800,
  );

  static const prominentButtonLabel = AppTextStyle(
    fontSize: AppTypography.font17,
    fontWeight: AppTypography.weight700,
  );

  static const authButtonLabel = AppTextStyle(
    fontSize: AppTypography.font19,
    fontWeight: AppTypography.weight700,
  );

  static const jumboButtonLabel = AppTextStyle(
    fontSize: AppTypography.font20,
    fontWeight: AppTypography.weight700,
  );

  static const profileButtonLabelCompact = AppTextStyle(
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight900,
    letterSpacing: AppTypography.letterSpacingn0_2,
  );

  static const profileButtonLabel = AppTextStyle(
    fontSize: AppTypography.font18,
    fontWeight: AppTypography.weight900,
    letterSpacing: AppTypography.letterSpacingn0_2,
  );

  static const textAction = AppTextStyle(
    fontSize: AppTypography.font15,
    fontWeight: AppTypography.weight600,
    color: AppColors.primary,
  );

  static const inputText = AppTextStyle(
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight400,
  );

  static const inputHint = AppTextStyle(
    color: AppColors.textSecondary,
    fontSize: AppTypography.font16,
    fontWeight: AppTypography.weight400,
  );

  static const badgeLabel = AppTextStyle(
    fontSize: AppTypography.font10_5,
    fontWeight: AppTypography.weight700,
    height: AppTypography.lineHeight1,
  );

  static const navigationLabel = AppTextStyle(
    fontSize: AppTypography.font11,
    fontWeight: AppTypography.weight600,
  );
}
