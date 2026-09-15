import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_nutrient_app/core/design_system/design_system.dart';

void main() {
  group('design token visual contract', () {
    test('brand and semantic colors retain their pre-refactor values', () {
      expect(AppColors.primary, const Color(0xFF079447));
      expect(AppColors.primaryDark, const Color(0xFF08763C));
      expect(AppColors.textPrimary, const Color(0xFF111820));
      expect(AppColors.textSecondary, const Color(0xFF68707C));
      expect(AppColors.border, const Color(0xFFE5E8EA));
      expect(AppColors.error, const Color(0xFFD92D3A));
    });

    test('layout and typography primitives retain exact values', () {
      expect(AppSpacing.v16, 16);
      expect(AppSpacing.v22, 22);
      expect(AppRadii.v12, 12);
      expect(AppRadii.v18, 18);
      expect(AppTypography.font16, 16);
      expect(AppTypography.font19, 19);
      expect(AppTypography.weight700, FontWeight.w700);
      expect(AppBreakpoints.compactPhone, 360);
      expect(AppBreakpoints.tablet, 600);
      expect(AppBreakpoints.contentMaxWidth, 620);
    });

    test('shadow recipes retain exact elevation geometry', () {
      final card = AppShadows.softCard.single;
      expect(card.color, const Color(0x08000000));
      expect(card.blurRadius, 8);
      expect(card.offset, const Offset(0, 2));

      final bottomBar = AppShadows.bottomBar.single;
      expect(bottomBar.color, const Color(0x0A000000));
      expect(bottomBar.blurRadius, 8);
      expect(bottomBar.offset, const Offset(0, -2));
    });

    test('central asset paths and icons retain their contracts', () {
      expect(AppAssets.loginHeader, 'assets/images/login_header.png');
      expect(
        AppAssets.loginIllustration,
        'assets/images/login_illustration.png',
      );
      expect(AppAssets.scanwellWordmark, 'assets/images/scanwell_wordmark.png');
      expect(
        AppAssets.signupIllustration,
        'assets/images/signup_illustration.png',
      );
      expect(
        AppAssets.verifyIllustration,
        'assets/images/verify_illustration.png',
      );
      expect(AppIcons.lock, Icons.lock);
      expect(AppIcons.search_rounded, Icons.search_rounded);
    });
  });

  group('theme visual contract', () {
    test('light theme preserves existing form styling', () {
      final theme = AppTheme.light;
      final input = theme.inputDecorationTheme;

      expect(theme.scaffoldBackgroundColor, AppColors.white);
      expect(theme.dividerColor, AppColors.divider);
      expect(input.filled, isTrue);
      expect(input.fillColor, AppColors.white);
      expect(
        input.contentPadding,
        const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      );

      final enabled = input.enabledBorder! as OutlineInputBorder;
      final focused = input.focusedBorder! as OutlineInputBorder;
      expect(enabled.borderRadius, BorderRadius.circular(12));
      expect(enabled.borderSide.color, AppColors.border);
      expect(focused.borderRadius, BorderRadius.circular(12));
      expect(focused.borderSide.color, AppColors.primary);
      expect(focused.borderSide.width, 1.4);
    });
  });
}
