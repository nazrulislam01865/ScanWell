import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_radii.dart';
import '../tokens/app_sizes.dart';
import '../tokens/app_spacing.dart';
import '../typography/app_text_styles.dart';
import '../typography/app_typography.dart';

/// Application theme composition.
///
/// Primitive values live in tokens and semantic text styles live in
/// [AppTextStyles]. Reusable application components (for example [AppButton])
/// own their richer visual variants. Theme-level component configuration stays
/// deliberately conservative so previously-unstyled Material widgets keep their
/// existing geometry while still inheriting the central brand palette/font.
abstract final class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTypography.fontFamily,
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        error: AppColors.error,
        surface: AppColors.surface,
      ),
    );

    return base.copyWith(
      // Keep Material's existing typography metrics for any intentionally
      // unstyled Text. Screens opt into semantic roles through AppTextStyles.
      textTheme: AppTypography.applyTo(base.textTheme),
      dividerColor: AppColors.divider,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.v17,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.input)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.input)),
          borderSide: BorderSide(color: AppColors.primary, width: 1.4),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.input)),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.input)),
          borderSide: BorderSide(color: AppColors.error, width: 1.4),
        ),
        hintStyle: AppTextStyles.inputHint.copyWith(
          color: AppColors.toneFF8A909A,
        ),
      ),

      // Fallback Material button themes intentionally only centralize brand
      // colors. AppButton owns size/radius/typography variants, which avoids
      // changing legacy dialog/action geometry that previously used defaults.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(iconSize: AppSizes.iconLg),
      ),
    );
  }
}
